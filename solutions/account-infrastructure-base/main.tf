########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
  source = "../.."
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  region                                     = var.region
  provision_atracker_cos                     = var.provision_atracker_cos
  resource_group_name                        = "${var.prefix}-resource-group"
  cos_instance_name                          = "${var.prefix}-cos-instance"
  cos_bucket_name                            = "${var.prefix}-cos-bucket"
  trusted_profile_name                       = "${var.prefix}-trusted-profile"
  cos_target_name                            = "${var.prefix}-cos-target"
  cos_bucket_management_endpoint_type        = var.cos_bucket_management_endpoint_type
  activity_tracker_route_name                = "${var.prefix}-cos-route"
  kms_key_crn                                = var.kms_key_crn
  resource_tags                              = var.resource_tags
  allowed_ip_addresses                       = var.allowed_ip_addresses
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
