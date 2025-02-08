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
  # tflint-ignore: terraform_unused_declarations
  validate_trusted_profile_name_provision = var.provision_trusted_profile_projects && var.trusted_profile_name == null ? tobool("'var.trusted_profile_name' cannot be null if 'var.provision_trusted_profile_projects' is true") : true

  # cos/atracker outputs
  cos_bucket               = var.provision_atracker_cos ? module.cos[0].buckets[var.cos_bucket_name] : null
  cos_instance_guid        = var.provision_atracker_cos ? module.cos[0].cos_instance_guid : null
  cos_instance_id          = var.provision_atracker_cos ? module.cos[0].cos_instance_id : null
  activity_tracker_targets = var.provision_atracker_cos ? module.activity_tracker[0].activity_tracker_targets[var.cos_target_name] : null
  activity_tracker_routes  = var.provision_atracker_cos ? module.activity_tracker[0].activity_tracker_routes : null

  # resource group logic
  rg_vars = {
    security_resource_group      = var.security_resource_group_name,
    audit_resource_group         = var.audit_resource_group_name,
    observability_resource_group = var.observability_resource_group_name,
    management_resource_group    = var.management_resource_group_name,
    workload_resource_group      = var.workload_resource_group_name,
    edge_resource_group          = var.edge_resource_group_name,
    devops_resource_group        = var.devops_resource_group_name
  }
  rg_list = distinct(compact(values(local.rg_vars)))

  rg_map = { for name in local.rg_list :
    name => [for k, v in local.rg_vars : k if name == v]
  }

  #existing resource group logic
  existing_rg_vars = {
    existing_security_resource_group      = var.existing_security_resource_group_name,
    existing_audit_resource_group         = var.existing_audit_resource_group_name,
    existing_observability_resource_group = var.existing_observability_resource_group_name,
    existing_management_resource_group    = var.existing_management_resource_group_name,
    existing_workload_resource_group      = var.existing_workload_resource_group_name,
    existing_edge_resource_group          = var.existing_edge_resource_group_name,
    existing_devops_resource_group        = var.existing_devops_resource_group_name
  }

  existing_rg_list = distinct(compact(values(local.existing_rg_vars)))

  existing_rg_map = { for name in local.existing_rg_list :
    name => [for k, v in local.rg_vars : k if name == v]
  }

  # resource group validations
  # tflint-ignore: terraform_unused_declarations
  validate_observability_resource_group = var.existing_observability_resource_group_name == null && var.observability_resource_group_name == null && var.provision_atracker_cos ? tobool("'existing_observability_resource_group_name' or 'observability_resource_group_name' must be provided if 'provision_atracker_cos' is true") : true

  # resource group outputs
  security_resource_group = local.existing_rg_vars["existing_security_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_security_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_security_resource_group"]].resource_group_name
    } : local.rg_vars["security_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["security_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["security_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  audit_resource_group = local.existing_rg_vars["existing_audit_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_audit_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_audit_resource_group"]].resource_group_name
    } : local.rg_vars["audit_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["audit_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["audit_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  observability_resource_group = local.existing_rg_vars["existing_observability_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_observability_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_observability_resource_group"]].resource_group_name
    } : local.rg_vars["observability_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["observability_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["observability_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  management_resource_group = local.existing_rg_vars["existing_management_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_management_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_management_resource_group"]].resource_group_name
    } : local.rg_vars["management_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["management_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["management_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  workload_resource_group = local.existing_rg_vars["existing_workload_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_workload_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_workload_resource_group"]].resource_group_name
    } : local.rg_vars["workload_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["workload_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["workload_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  edge_resource_group = local.existing_rg_vars["existing_edge_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_edge_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_edge_resource_group"]].resource_group_name
    } : local.rg_vars["edge_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["edge_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["edge_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  devops_resource_group = local.existing_rg_vars["existing_devops_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_devops_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_devops_resource_group"]].resource_group_name
    } : local.rg_vars["devops_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["devops_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["devops_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }

  cos_rg = !var.provision_atracker_cos ? "" : local.observability_resource_group.id
}

module "resource_group" {
  for_each            = local.rg_map
  source              = "terraform-ibm-modules/resource-group/ibm"
  version             = "1.1.6"
  resource_group_name = each.key
}

moved {
  from = module.existing_resource_group[0]
  to   = module.existing_resource_group["existing_observability_resource_group"]
}

module "existing_resource_group" {
  for_each                     = local.existing_rg_map
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  existing_resource_group_name = each.key
}

moved {
  from = module.account_settings
  to   = module.account_settings[0]
}

module "account_settings" {
  count                        = !var.skip_iam_account_settings ? 1 : 0
  source                       = "terraform-ibm-modules/iam-account-settings/ibm"
  version                      = "2.10.7"
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
  skip_cloud_shell_calls       = var.skip_cloud_shell_calls
}

module "cos" {
  count             = var.provision_atracker_cos ? 1 : 0
  source            = "terraform-ibm-modules/cos/ibm//modules/fscloud"
  version           = "8.13.5"
  resource_group_id = local.cos_rg
  bucket_configs = [{
    access_tags                   = var.cos_bucket_access_tags
    bucket_name                   = var.cos_bucket_name
    kms_encryption_enabled        = true
    kms_key_crn                   = var.kms_key_crn
    kms_guid                      = var.provision_atracker_cos && !var.skip_cos_kms_auth_policy ? split(":", var.kms_key_crn)[7] : null
    skip_iam_authorization_policy = var.skip_cos_kms_auth_policy
    management_endpoint_type      = var.cos_bucket_management_endpoint_type
    storage_class                 = var.cos_bucket_storage_class
    region_location               = var.region
    object_versioning = {
      enable = var.cos_bucket_object_versioning_enabled
    }
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
}

module "activity_tracker" {
  count   = var.provision_atracker_cos ? 1 : 0
  source  = "terraform-ibm-modules/observability-instances/ibm//modules/activity_tracker"
  version = "3.3.0"
  activity_tracker_routes = [
    {
      route_name = var.activity_tracker_route_name
      locations  = var.activity_tracker_locations
      target_ids = [local.activity_tracker_targets.id]
    }
  ]
  cos_targets = [
    {
      bucket_name                       = local.cos_bucket.bucket_name
      endpoint                          = local.cos_bucket.s3_endpoint_private
      instance_id                       = local.cos_bucket.cos_instance_id
      target_region                     = var.region
      target_name                       = var.cos_target_name
      service_to_service_enabled        = true
      skip_atracker_cos_iam_auth_policy = var.skip_atracker_cos_iam_auth_policy
    }
  ]
}

moved {
  from = module.trusted_profile_projects
  to   = module.trusted_profile_projects[0]
}

module "trusted_profile_projects" {
  count                       = var.provision_trusted_profile_projects ? 1 : 0
  source                      = "terraform-ibm-modules/trusted-profile/ibm"
  version                     = "2.0.0"
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
  count                                  = var.provision_cbr ? 1 : 0
  source                                 = "terraform-ibm-modules/cbr/ibm//modules/fscloud"
  version                                = "1.29.0"
  prefix                                 = var.cbr_prefix
  zone_vpc_crn_list                      = []
  allow_cos_to_kms                       = var.cbr_allow_cos_to_kms
  allow_block_storage_to_kms             = var.cbr_allow_block_storage_to_kms
  allow_roks_to_kms                      = var.cbr_allow_roks_to_kms
  allow_icd_to_kms                       = var.cbr_allow_icd_to_kms
  allow_event_streams_to_kms             = var.cbr_allow_event_streams_to_kms
  allow_vpcs_to_container_registry       = var.cbr_allow_vpcs_to_container_registry
  allow_vpcs_to_cos                      = var.cbr_allow_vpcs_to_cos
  allow_at_to_cos                        = var.cbr_allow_at_to_cos
  allow_iks_to_is                        = var.cbr_allow_iks_to_is
  allow_is_to_cos                        = var.cbr_allow_is_to_cos
  allow_scc_to_cos                       = var.cbr_allow_scc_to_cos
  allow_vpcs_to_iam_groups               = var.cbr_allow_vpcs_to_iam_groups
  allow_vpcs_to_iam_access_management    = var.cbr_allow_vpcs_to_iam_access_management
  kms_service_targeted_by_prewired_rules = var.cbr_kms_service_targeted_by_prewired_rules
  target_service_details                 = var.cbr_target_service_details
}
