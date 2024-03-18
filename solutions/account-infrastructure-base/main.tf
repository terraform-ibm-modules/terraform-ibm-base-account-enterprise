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

  access_groups = [{
    access_group_name = "${var.prefix}-access-group"
    dynamic_rules = {
      "dynamic-rule-example" = {
        condition = [{
          claim    = "test_claim"
          operator = "CONTAINS"
          value    = "test_value"
        }]
        expiration        = 3
        identity_provider = "https://idp-test.example.org/SAML2"
      }
    }
    policies = {
      "test-policy" = {
        roles = ["Viewer"]
        tags  = ["account-infrastructure-base-example"]
      }
    }
  }]

  custom_roles = [{
    actions      = ["cloud-object-storage.bucket.get"]
    display_name = "account-base-test-custom-role"
    name         = "account-base-test-custom-role"
    service      = "cloud-object-storage"
  }]
}
