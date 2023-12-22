########################################################################################################################
# Base Account
########################################################################################################################

module "base_layer" {
  source = "../.."
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  region                              = var.region
  resource_group_name                 = "${var.prefix}-resource-group"
  cos_instance_name                   = "${var.prefix}-cos-instance"
  cos_bucket_name                     = "${var.prefix}-cos-bucket"
  trusted_profile_name                = "${var.prefix}-trusted-profile"
  cos_target_name                     = "${var.prefix}-target"
  cos_bucket_management_endpoint_type = "public"
  activity_tracker_route_name         = "${var.prefix}-route"
  kms_encryption_enabled              = true
  kms_guid                            = var.kms_guid
  kms_key_crn                         = var.kms_key_crn
  resource_tags                       = var.resource_tags
}
