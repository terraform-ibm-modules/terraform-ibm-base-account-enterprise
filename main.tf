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

module "cos_bucket_atracker" {
  source                 = "terraform-ibm-modules/cos/ibm"
  version                = "7.0.7"
  resource_group_id      = module.resource_group.resource_group_id
  region                 = var.region
  cos_instance_name      = var.cos_instance_name
  cos_tags               = var.resource_tags
  bucket_name            = var.cos_bucket_name
  kms_encryption_enabled = false
  retention_enabled      = false
}

module "atracker" {
  source  = "terraform-ibm-modules/observability-instances/ibm"
  version = "2.10.1"
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  resource_group_id              = module.resource_group.resource_group_id
  region                         = var.region
  activity_tracker_instance_name = var.activity_tracker_instance_name
  activity_tracker_plan          = var.activity_tracker_plan
  activity_tracker_tags          = var.resource_tags
  at_cos_bucket_endpoint         = module.cos_bucket_atracker.s3_endpoint_private
  at_cos_bucket_name             = module.cos_bucket_atracker.bucket_name
  at_cos_instance_id             = module.cos_bucket_atracker.cos_instance_id
  enable_archive                 = true
}

module "trusted_profile_projects" {
  source                      = "terraform-ibm-modules/trusted-profile/ibm"
  version                     = "1.0.0"
  trusted_profile_name        = var.trusted_profile_name
  trusted_profile_description = var.trusted_profile_description
  trusted_profile_policies = [{
    roles = var.trusted_profile_roles
    resources = [{
      service = "project"
    }]
  }]
}
