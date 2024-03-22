########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
  source               = "../.."
  trusted_profile_name = "${var.prefix}-trusted-profile"
  allowed_ip_addresses = var.allowed_ip_addresses
}
