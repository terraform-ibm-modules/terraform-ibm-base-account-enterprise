########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
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
  cos_target_name                     = "${var.prefix}-cos-target"
  cos_bucket_management_endpoint_type = var.cos_bucket_management_endpoint_type
  activity_tracker_route_name         = "${var.prefix}-cos-route"
  kms_key_crn                         = var.kms_key_crn
  resource_tags                       = var.resource_tags
  allowed_ip_addresses                = var.allowed_ip_addresses
  custom_roles                        = var.custom_roles
  access_groups = [{
    access_group_name = "${var.prefix}-admin"
    description       = "Access Group with full Administrator privileges"
    policies = {
      "acct-admin" = {
        account_management = true
        roles              = ["Administrator"]
      },
      "res-group" = {
        roles = ["Administrator"]
        resource_attributes = [{
          name  = "resourceGroupId"
          value = "*"
        }]
      },
      "all-iam" = {
        roles = ["Administrator", "Manager"]
        resources = [{
          service = "iam-access-management"
        }]
      }
    }
  }]
}
