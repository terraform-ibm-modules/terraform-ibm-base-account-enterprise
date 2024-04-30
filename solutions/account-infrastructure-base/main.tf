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
  provision_atracker_cos              = var.provision_atracker_cos
  cos_instance_name                   = try("${var.prefix}-cos-instance", "cos-instance")
  cos_bucket_name                     = try("${var.prefix}-cos-bucket", "cos-bucket")
  cos_target_name                     = try("${var.prefix}-cos-target", "cos-target")
  activity_tracker_route_name         = try("${var.prefix}-cos-route", "cos-route")
  cos_bucket_management_endpoint_type = var.cos_bucket_management_endpoint_type
  kms_key_crn                         = var.kms_key_crn
  resource_tags                       = var.resource_tags

  # iam account settings
  allowed_ip_addresses = var.allowed_ip_addresses

  # trusted profile
  trusted_profile_name = try("${var.prefix}-trusted-profile", "projects-trusted-profile")

  # cbr
  provision_cbr                              = var.provision_cbr
  cbr_prefix                                 = var.prefix
  cbr_allow_cos_to_kms                       = var.cbr_allow_cos_to_kms
  cbr_allow_block_storage_to_kms             = var.cbr_allow_block_storage_to_kms
  cbr_allow_roks_to_kms                      = var.cbr_allow_roks_to_kms
  cbr_allow_icd_to_kms                       = var.cbr_allow_icd_to_kms
  cbr_allow_event_streams_to_kms             = var.cbr_allow_event_streams_to_kms
  cbr_allow_vpcs_to_container_registry       = var.cbr_allow_vpcs_to_container_registry
  cbr_allow_vpcs_to_cos                      = var.cbr_allow_vpcs_to_cos
  cbr_allow_at_to_cos                        = var.cbr_allow_at_to_cos
  cbr_allow_iks_to_is                        = var.cbr_allow_iks_to_is
  cbr_allow_is_to_cos                        = var.cbr_allow_is_to_cos
  cbr_kms_service_targeted_by_prewired_rules = var.cbr_kms_service_targeted_by_prewired_rules
}
