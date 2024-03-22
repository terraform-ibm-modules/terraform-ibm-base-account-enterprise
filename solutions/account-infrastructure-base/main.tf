########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
  source               = "../.."
  trusted_profile_name = var.trusted_profile_name
  allowed_ip_addresses = var.allowed_ip_addresses
}
