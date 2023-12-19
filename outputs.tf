########################################################################################################################
# Outputs
########################################################################################################################

output "resource_group" {
  value = module.resource_group
}

output "account_settings" {
  value = module.account_settings
}

output "cos_bucket" {
  value = module.cos_bucket_atracker
}

output "atracker" {
  value = module.atracker
}

output "trusted_profile_projects" {
  value = module.trusted_profile_projects
}
