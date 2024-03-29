##############################################################################
# Account infrastructure base module
##############################################################################

locals {
  # input validation
  # tflint-ignore: terraform_unused_declarations
  validate_atracker_provision_cos_instance_name = var.provision_atracker_cos && var.cos_instance_name == null ? tobool("'var.cos_instance_name' cannot be null if 'var.provision_atracker_cos' is true") : true
  # tflint-ignore: terraform_unused_declarations
  validate_atracker_provision_cos_bucket_name = var.provision_atracker_cos && var.cos_bucket_name == null ? tobool("'var.cos_bucket_name' cannot be null if 'var.provision_atracker_cos' is true") : true
  # tflint-ignore: terraform_unused_declarations
  validate_atracker_provision_kms_key_crn = var.provision_atracker_cos && var.kms_key_crn == null ? tobool("'var.kms_key_crn' cannot be null if 'var.provision_atracker_cos' is true") : true
  # tflint-ignore: terraform_unused_declarations
  validate_atracker_provision_cos_target_name = var.provision_atracker_cos && var.cos_target_name == null ? tobool("'var.cos_target_name' cannot be null if 'var.provision_atracker_cos' is true") : true
  # tflint-ignore: terraform_unused_declarations
  validate_atracker_provision_activity_tracker_route_name = var.provision_atracker_cos && var.activity_tracker_route_name == null ? tobool("'var.activity_tracker_route_name' cannot be null if 'var.provision_atracker_cos' is true") : true

  # outputs
  cos_bucket               = var.provision_atracker_cos ? module.cos[0].buckets[var.cos_bucket_name] : null
  cos_instance_guid        = var.provision_atracker_cos ? module.cos[0].cos_instance_guid : null
  cos_instance_id          = var.provision_atracker_cos ? module.cos[0].cos_instance_id : null
  activity_tracker_targets = var.provision_atracker_cos ? module.activity_tracker[0].activity_tracker_targets[var.cos_target_name] : null
  activity_tracker_routes  = var.provision_atracker_cos ? module.activity_tracker[0].activity_tracker_routes : null
}

module "resource_group" {
  source              = "terraform-ibm-modules/resource-group/ibm"
  version             = "1.1.4"
  resource_group_name = var.resource_group_name
}

module "account_settings" {
  source                       = "terraform-ibm-modules/iam-account-settings/ibm"
  version                      = "2.5.0"
  access_token_expiration      = var.access_token_expiration
  active_session_timeout       = var.active_session_timeout
  allowed_ip_addresses         = var.allowed_ip_addresses
  api_creation                 = var.api_creation
  enforce_allowed_ip_addresses = var.enforce_allowed_ip_addresses
  inactive_session_timeout     = var.inactive_session_timeout
  max_sessions_per_identity    = var.max_sessions_per_identity
  mfa                          = var.mfa
  public_access_enabled        = var.public_access_enabled
  refresh_token_expiration     = var.refresh_token_expiration
  serviceid_creation           = var.serviceid_creation
  shell_settings_enabled       = var.shell_settings_enabled
  user_mfa                     = var.user_mfa
  user_mfa_reset               = var.user_mfa_reset
}

module "cos" {
  count             = var.provision_atracker_cos ? 1 : 0
  source            = "terraform-ibm-modules/cos/ibm//modules/fscloud"
  version           = "7.1.3"
  resource_group_id = module.resource_group.resource_group_id
  bucket_configs = [{
    access_tags                   = var.cos_bucket_access_tags
    bucket_name                   = var.cos_bucket_name
    kms_encryption_enabled        = true
    kms_key_crn                   = var.kms_key_crn
    skip_iam_authorization_policy = true
    management_endpoint_type      = var.cos_bucket_management_endpoint_type
    storage_class                 = var.cos_bucket_storage_class
    object_versioning_enabled     = var.cos_bucket_object_versioning_enabled
    region_location               = var.region
    resource_group_id             = module.resource_group.resource_group_id
    archive_rule = {
      enable = var.cos_bucket_archive_enabled
      days   = var.cos_bucket_archive_days
      type   = var.cos_bucket_archive_type
    }
    expire_rule = {
      enable = var.cos_bucket_expire_enabled
      days   = var.cos_bucket_expire_days
    }
    retention_rule = var.cos_bucket_retention_enabled ? {
      default   = var.cos_bucket_retention_default
      maximum   = var.cos_bucket_retention_maximum
      minimum   = var.cos_bucket_retention_minimum
      permanent = var.cos_bucket_retention_permanent
    } : null
    cbr_rules = var.cos_bucket_cbr_rules
  }]
  cos_instance_name  = var.cos_instance_name
  cos_plan           = var.cos_plan
  cos_tags           = var.resource_tags
  instance_cbr_rules = var.cos_instance_cbr_rules
  access_tags        = var.cos_instance_access_tags
  create_hmac_key    = false
}

resource "ibm_iam_authorization_policy" "atracker_cos" {
  count                       = var.provision_atracker_cos ? (var.skip_atracker_cos_iam_auth_policy ? 0 : 1) : 0
  source_service_name         = "atracker"
  target_service_name         = "cloud-object-storage"
  target_resource_instance_id = local.cos_instance_guid
  roles                       = ["Object Writer"]
  description                 = "Permit AT service Object Writer access to COS instance ${local.cos_instance_id}"
}

module "activity_tracker" {
  count   = var.provision_atracker_cos ? 1 : 0
  source  = "terraform-ibm-modules/observability-instances/ibm//modules/activity_tracker"
  version = "2.10.3"
  providers = {
    logdna.at = logdna.at
  }
  activity_tracker_provision = false
  activity_tracker_routes = [
    {
      route_name = var.activity_tracker_route_name
      locations  = var.activity_tracker_locations
      target_ids = [local.activity_tracker_targets.id]
    }
  ]
  cos_targets = [
    {
      bucket_name                = local.cos_bucket.bucket_name
      endpoint                   = local.cos_bucket.s3_endpoint_private
      instance_id                = local.cos_bucket.cos_instance_id
      target_region              = var.region
      target_name                = var.cos_target_name
      service_to_service_enabled = true
    }
  ]
}

module "trusted_profile_projects" {
  source                      = "terraform-ibm-modules/trusted-profile/ibm"
  version                     = "1.0.1"
  trusted_profile_name        = var.trusted_profile_name
  trusted_profile_description = var.trusted_profile_description
  trusted_profile_policies = [{
    roles = var.trusted_profile_roles
    resources = [{
      service = "project"
    }]
  }]
}

module "cbr_fscloud" {
  source                           = "terraform-ibm-modules/cbr/ibm//modules/fscloud"
  version                          = "1.20.0"
  prefix                           = var.cbr_prefix
  zone_vpc_crn_list                = []
  allow_cos_to_kms                 = var.cbr_allow_cos_to_kms
  allow_block_storage_to_kms       = var.cbr_allow_block_storage_to_kms
  allow_roks_to_kms                = var.cbr_allow_roks_to_kms
  allow_icd_to_kms                 = var.cbr_allow_icd_to_kms
  allow_event_streams_to_kms       = var.cbr_allow_event_streams_to_kms
  allow_vpcs_to_container_registry = var.cbr_allow_vpcs_to_container_registry
  allow_vpcs_to_cos                = var.cbr_allow_vpcs_to_cos
  allow_at_to_cos                  = var.cbr_allow_at_to_cos
  allow_iks_to_is                  = var.cbr_allow_iks_to_is
  allow_is_to_cos                  = var.cbr_allow_is_to_cos
}
