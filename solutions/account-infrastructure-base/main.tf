########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
  source = "../.."
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  region = var.region

  # resource groups
  audit_resource_group_name                  = try("${var.prefix}-${var.audit_resource_group_name}", var.audit_resource_group_name, null)
  existing_audit_resource_group_name         = var.existing_audit_resource_group_name
  devops_resource_group_name                 = try("${var.prefix}-${var.devops_resource_group_name}", var.devops_resource_group_name, null)
  existing_devops_resource_group_name        = var.existing_devops_resource_group_name
  edge_resource_group_name                   = try("${var.prefix}-${var.edge_resource_group_name}", var.edge_resource_group_name, null)
  existing_edge_resource_group_name          = var.existing_edge_resource_group_name
  management_resource_group_name             = try("${var.prefix}-${var.management_resource_group_name}", var.management_resource_group_name, null)
  existing_management_resource_group_name    = var.existing_management_resource_group_name
  observability_resource_group_name          = try("${var.prefix}-${var.observability_resource_group_name}", var.observability_resource_group_name, null)
  existing_observability_resource_group_name = var.existing_observability_resource_group_name
  security_resource_group_name               = try("${var.prefix}-${var.security_resource_group_name}", var.security_resource_group_name, null)
  existing_security_resource_group_name      = var.existing_security_resource_group_name
  workload_resource_group_name               = try("${var.prefix}-${var.workload_resource_group_name}", var.workload_resource_group_name, null)
  existing_workload_resource_group_name      = var.existing_workload_resource_group_name

  # atracker + cos
  provision_atracker_cos               = var.provision_atracker_cos
  skip_cos_kms_auth_policy             = var.skip_cos_kms_auth_policy
  cos_instance_name                    = !var.provision_atracker_cos ? null : (var.cos_instance_name == null ? try("${var.prefix}-cos-instance", "cos-instance") : var.cos_instance_name)
  cos_bucket_name                      = !var.provision_atracker_cos ? null : (var.cos_bucket_name == null ? try("${lower(var.prefix)}-cos-bucket", "cos-bucket") : var.cos_bucket_name)
  cos_target_name                      = !var.provision_atracker_cos ? null : (var.cos_target_name == null ? try("${var.prefix}-cos-target", "cos-target") : var.cos_target_name)
  activity_tracker_route_name          = var.activity_tracker_route_name == null ? try("${var.prefix}-cos-route", "cos-route") : var.activity_tracker_route_name
  cos_bucket_management_endpoint_type  = var.cos_bucket_management_endpoint_type
  kms_key_crn                          = var.kms_key_crn
  resource_tags                        = var.resource_tags
  cos_plan                             = var.cos_plan
  cos_instance_access_tags             = var.cos_instance_access_tags
  cos_bucket_access_tags               = var.cos_bucket_access_tags
  cos_bucket_expire_enabled            = var.cos_bucket_expire_enabled
  cos_bucket_expire_days               = var.cos_bucket_expire_days
  cos_bucket_object_versioning_enabled = var.cos_bucket_object_versioning_enabled
  cos_bucket_storage_class             = var.cos_bucket_storage_class
  cos_bucket_archive_enabled           = var.cos_bucket_archive_enabled
  cos_bucket_archive_days              = var.cos_bucket_archive_days
  cos_bucket_archive_type              = var.cos_bucket_archive_type
  cos_bucket_retention_enabled         = var.cos_bucket_retention_enabled
  cos_bucket_retention_default         = var.cos_bucket_retention_default
  cos_bucket_retention_maximum         = var.cos_bucket_retention_maximum
  cos_bucket_retention_minimum         = var.cos_bucket_retention_minimum
  cos_bucket_retention_permanent       = var.cos_bucket_retention_permanent
  skip_atracker_cos_iam_auth_policy    = var.skip_atracker_cos_iam_auth_policy
  activity_tracker_locations           = var.activity_tracker_locations

  # iam account settings
  skip_iam_account_settings    = var.skip_iam_account_settings
  allowed_ip_addresses         = var.allowed_ip_addresses
  access_token_expiration      = var.access_token_expiration
  active_session_timeout       = var.active_session_timeout
  api_creation                 = var.api_creation
  enforce_allowed_ip_addresses = var.enforce_allowed_ip_addresses
  inactive_session_timeout     = var.inactive_session_timeout
  max_sessions_per_identity    = var.max_sessions_per_identity
  mfa                          = var.mfa
  public_access_enabled        = var.public_access_enabled
  refresh_token_expiration     = var.refresh_token_expiration
  serviceid_creation           = var.serviceid_creation
  shell_settings_enabled       = var.shell_settings_enabled
  skip_cloud_shell_calls       = var.skip_cloud_shell_calls
  user_mfa                     = var.user_mfa
  user_mfa_reset               = var.user_mfa_reset

  # trusted profile
  trusted_profile_name               = var.trusted_profile_name == null ? try("${var.prefix}-trusted-profile", "projects-trusted-profile") : var.trusted_profile_name
  provision_trusted_profile_projects = var.provision_trusted_profile_projects
  trusted_profile_description        = var.trusted_profile_description
  trusted_profile_roles              = var.trusted_profile_roles
}
