##############################################################################
# Base Account Module
##############################################################################

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
  source            = "terraform-ibm-modules/cos/ibm//modules/fscloud"
  version           = "7.0.7"
  resource_group_id = module.resource_group.resource_group_id
  bucket_configs = [{
    access_tags                   = var.cos_bucket_access_tags
    bucket_name                   = var.cos_bucket_name
    kms_encryption_enabled        = var.kms_encryption_enabled
    kms_guid                      = var.kms_guid
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
  create_hmac_key    = false
  instance_cbr_rules = var.cos_instance_cbr_rules
}

resource "ibm_resource_key" "cos_resource_key" {
  name                 = var.cos_hmac_key_name
  resource_instance_id = module.cos.cos_instance_id
  role                 = var.cos_hmac_key_role
}

module "activity_tracker" {
  source  = "terraform-ibm-modules/observability-instances/ibm//modules/activity_tracker"
  version = "2.10.1"
  providers = {
    logdna.at = logdna.at
  }
  activity_tracker_provision = false
  activity_tracker_routes = [
    {
      route_name = var.activity_tracker_route_name
      locations  = var.activity_tracker_locations
      target_ids = [module.activity_tracker.activity_tracker_targets[var.cos_target_name].id]
    }
  ]
  cos_targets = [
    {
      api_key       = ibm_resource_key.cos_resource_key.credentials.apikey
      bucket_name   = module.cos.buckets[var.cos_bucket_name].bucket_name
      endpoint      = module.cos.buckets[var.cos_bucket_name].s3_endpoint_private
      instance_id   = module.cos.cos_instance_id
      target_region = var.region
      target_name   = var.cos_target_name
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
