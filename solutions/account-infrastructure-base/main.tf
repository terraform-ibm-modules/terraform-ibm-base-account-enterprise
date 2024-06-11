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
  audit_resource_group_name         = try("${var.prefix}-${var.audit_resource_group_name}", var.audit_resource_group_name, null)
  devops_resource_group_name        = try("${var.prefix}-${var.devops_resource_group_name}", var.devops_resource_group_name, null)
  edge_resource_group_name          = try("${var.prefix}-${var.edge_resource_group_name}", var.edge_resource_group_name, null)
  management_resource_group_name    = try("${var.prefix}-${var.management_resource_group_name}", var.management_resource_group_name, null)
  observability_resource_group_name = try("${var.prefix}-${var.observability_resource_group_name}", var.observability_resource_group_name, null)
  security_resource_group_name      = try("${var.prefix}-${var.security_resource_group_name}", var.security_resource_group_name, null)
  workload_resource_group_name      = try("${var.prefix}-${var.workload_resource_group_name}", var.workload_resource_group_name, null)
  existing_cos_resource_group_name  = var.existing_cos_resource_group_name

  # atracker + cos
  provision_atracker_cos               = var.provision_atracker_cos
  skip_cos_kms_auth_policy             = var.skip_cos_kms_auth_policy
  cos_instance_name                    = var.cos_instance_name == null ? try("${var.prefix}-cos-instance", "cos-instance") : var.cos_instance_name
  cos_bucket_name                      = var.cos_bucket_name == null ? try("${var.prefix}-cos-bucket", "cos-bucket") : var.cos_bucket_name
  cos_target_name                      = var.cos_target_name == null ? try("${var.prefix}-cos-target", "cos-target") : var.cos_target_name
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

  # access management
  provision_access_management = var.provision_access_management

  # admin observability
  admin_observability_ag_name          = try("${var.prefix}-${var.admin_observability_ag_name}", var.admin_observability_ag_name, null)
  admin_observability_ag_policies      = var.admin_observability_ag_policies
  admin_observability_ag_dynamic_rules = var.admin_observability_ag_dynamic_rules
  admin_observability_ag_add_members   = var.admin_observability_ag_add_members
  admin_observability_ag_description   = var.admin_observability_ag_description
  admin_observability_ag_tags          = var.admin_observability_ag_tags
  admin_observability_ag_ibm_ids       = var.admin_observability_ag_ibm_ids
  admin_observability_ag_service_ids   = var.admin_observability_ag_service_ids

  # admin security
  admin_security_ag_name          = try("${var.prefix}-${var.admin_security_ag_name}", var.admin_security_ag_name, null)
  admin_security_ag_policies      = var.admin_security_ag_policies
  admin_security_ag_dynamic_rules = var.admin_security_ag_dynamic_rules
  admin_security_ag_add_members   = var.admin_security_ag_add_members
  admin_security_ag_description   = var.admin_security_ag_description
  admin_security_ag_tags          = var.admin_security_ag_tags
  admin_security_ag_ibm_ids       = var.admin_security_ag_ibm_ids
  admin_security_ag_service_ids   = var.admin_security_ag_service_ids

  # admin network
  admin_network_ag_name          = try("${var.prefix}-${var.admin_network_ag_name}", var.admin_network_ag_name, null)
  admin_network_ag_policies      = var.admin_network_ag_policies
  admin_network_ag_dynamic_rules = var.admin_network_ag_dynamic_rules
  admin_network_ag_add_members   = var.admin_network_ag_add_members
  admin_network_ag_description   = var.admin_network_ag_description
  admin_network_ag_tags          = var.admin_network_ag_tags
  admin_network_ag_ibm_ids       = var.admin_network_ag_ibm_ids
  admin_network_ag_service_ids   = var.admin_network_ag_service_ids

  # admin compute
  admin_compute_ag_name          = try("${var.prefix}-${var.admin_compute_ag_name}", var.admin_compute_ag_name, null)
  admin_compute_ag_policies      = var.admin_compute_ag_policies
  admin_compute_ag_dynamic_rules = var.admin_compute_ag_dynamic_rules
  admin_compute_ag_add_members   = var.admin_compute_ag_add_members
  admin_compute_ag_description   = var.admin_compute_ag_description
  admin_compute_ag_tags          = var.admin_compute_ag_tags
  admin_compute_ag_ibm_ids       = var.admin_compute_ag_ibm_ids
  admin_compute_ag_service_ids   = var.admin_compute_ag_service_ids

  # privileged observability
  privileged_observability_ag_name          = try("${var.prefix}-${var.privileged_observability_ag_name}", var.privileged_observability_ag_name, null)
  privileged_observability_ag_policies      = var.privileged_observability_ag_policies
  privileged_observability_ag_dynamic_rules = var.privileged_observability_ag_dynamic_rules
  privileged_observability_ag_add_members   = var.privileged_observability_ag_add_members
  privileged_observability_ag_description   = var.privileged_observability_ag_description
  privileged_observability_ag_tags          = var.privileged_observability_ag_tags
  privileged_observability_ag_ibm_ids       = var.privileged_observability_ag_ibm_ids
  privileged_observability_ag_service_ids   = var.privileged_observability_ag_service_ids

  # privileged security
  privileged_security_ag_name          = try("${var.prefix}-${var.privileged_security_ag_name}", var.privileged_security_ag_name, null)
  privileged_security_ag_policies      = var.privileged_security_ag_policies
  privileged_security_ag_dynamic_rules = var.privileged_security_ag_dynamic_rules
  privileged_security_ag_add_members   = var.privileged_security_ag_add_members
  privileged_security_ag_description   = var.privileged_security_ag_description
  privileged_security_ag_tags          = var.privileged_security_ag_tags
  privileged_security_ag_ibm_ids       = var.privileged_security_ag_ibm_ids
  privileged_security_ag_service_ids   = var.privileged_security_ag_service_ids

  # privileged network
  privileged_network_ag_name          = try("${var.prefix}-${var.privileged_network_ag_name}", var.privileged_network_ag_name, null)
  privileged_network_ag_policies      = var.privileged_network_ag_policies
  privileged_network_ag_dynamic_rules = var.privileged_network_ag_dynamic_rules
  privileged_network_ag_add_members   = var.privileged_network_ag_add_members
  privileged_network_ag_description   = var.privileged_network_ag_description
  privileged_network_ag_tags          = var.privileged_network_ag_tags
  privileged_network_ag_ibm_ids       = var.privileged_network_ag_ibm_ids
  privileged_network_ag_service_ids   = var.privileged_network_ag_service_ids

  # privileged compute
  privileged_compute_ag_name          = try("${var.prefix}-${var.privileged_compute_ag_name}", var.privileged_compute_ag_name, null)
  privileged_compute_ag_policies      = var.privileged_compute_ag_policies
  privileged_compute_ag_dynamic_rules = var.privileged_compute_ag_dynamic_rules
  privileged_compute_ag_add_members   = var.privileged_compute_ag_add_members
  privileged_compute_ag_description   = var.privileged_compute_ag_description
  privileged_compute_ag_tags          = var.privileged_compute_ag_tags
  privileged_compute_ag_ibm_ids       = var.privileged_compute_ag_ibm_ids
  privileged_compute_ag_service_ids   = var.privileged_compute_ag_service_ids

  # observer observability
  observer_observability_ag_name          = try("${var.prefix}-${var.observer_observability_ag_name}", var.observer_observability_ag_name, null)
  observer_observability_ag_policies      = var.observer_observability_ag_policies
  observer_observability_ag_dynamic_rules = var.observer_observability_ag_dynamic_rules
  observer_observability_ag_add_members   = var.observer_observability_ag_add_members
  observer_observability_ag_description   = var.observer_observability_ag_description
  observer_observability_ag_tags          = var.observer_observability_ag_tags
  observer_observability_ag_ibm_ids       = var.observer_observability_ag_ibm_ids
  observer_observability_ag_service_ids   = var.observer_observability_ag_service_ids

  # observer security
  observer_security_ag_name          = try("${var.prefix}-${var.observer_security_ag_name}", var.observer_security_ag_name, null)
  observer_security_ag_policies      = var.observer_security_ag_policies
  observer_security_ag_dynamic_rules = var.observer_security_ag_dynamic_rules
  observer_security_ag_add_members   = var.observer_security_ag_add_members
  observer_security_ag_description   = var.observer_security_ag_description
  observer_security_ag_tags          = var.observer_security_ag_tags
  observer_security_ag_ibm_ids       = var.observer_security_ag_ibm_ids
  observer_security_ag_service_ids   = var.observer_security_ag_service_ids

  # observer network
  observer_network_ag_name          = try("${var.prefix}-${var.observer_network_ag_name}", var.observer_network_ag_name, null)
  observer_network_ag_policies      = var.observer_network_ag_policies
  observer_network_ag_dynamic_rules = var.observer_network_ag_dynamic_rules
  observer_network_ag_add_members   = var.observer_network_ag_add_members
  observer_network_ag_description   = var.observer_network_ag_description
  observer_network_ag_tags          = var.observer_network_ag_tags
  observer_network_ag_ibm_ids       = var.observer_network_ag_ibm_ids
  observer_network_ag_service_ids   = var.observer_network_ag_service_ids

  # observer compute
  observer_compute_ag_name          = try("${var.prefix}-${var.observer_compute_ag_name}", var.observer_compute_ag_name, null)
  observer_compute_ag_policies      = var.observer_compute_ag_policies
  observer_compute_ag_dynamic_rules = var.observer_compute_ag_dynamic_rules
  observer_compute_ag_add_members   = var.observer_compute_ag_add_members
  observer_compute_ag_description   = var.observer_compute_ag_description
  observer_compute_ag_tags          = var.observer_compute_ag_tags
  observer_compute_ag_ibm_ids       = var.observer_compute_ag_ibm_ids
  observer_compute_ag_service_ids   = var.observer_compute_ag_service_ids
}
