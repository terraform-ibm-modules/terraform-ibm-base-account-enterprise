########################################################################################################################
# Base Account
########################################################################################################################

module "basic_account" {
  source = "../.."
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  region                         = var.region
  resource_group_name            = "${var.prefix}-resource-group"
  activity_tracker_instance_name = "${var.prefix}-atracker"
  activity_tracker_plan          = "lite"
  cos_instance_name              = "${var.prefix}-cos-instance"
  cos_bucket_name                = "${var.prefix}-cos-bucket"
  trusted_profile_name           = "${var.prefix}-trusted-profile"
  resource_tags                  = var.resource_tags
}

data "ibm_resource_key" "at_resource_key" {
  name                 = module.basic_account.atracker.activity_tracker_manager_key_name
  resource_instance_id = module.basic_account.atracker.crn
}
