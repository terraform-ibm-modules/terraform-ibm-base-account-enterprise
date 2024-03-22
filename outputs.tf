########################################################################################################################
# Outputs
########################################################################################################################

output "account_allowed_ip_addresses" {
  value       = module.account_settings.account_allowed_ip_addresses
  description = "Account Settings Allowed IP Addresses"
}

output "account_allowed_ip_addresses_control_mode" {
  value       = module.account_settings.account_allowed_ip_addresses_control_mode
  description = "Account Settings Allowed IP Addresses Control Mode"
}

output "account_allowed_ip_addresses_enforced" {
  value       = module.account_settings.account_allowed_ip_addresses_enforced
  description = "Account Settings Allowed IP Addresses Enforced"
}

output "account_iam_access_token_expiration" {
  value       = module.account_settings.account_iam_access_token_expiration
  description = "Account Settings IAM Access Token Expiration"
}

output "account_iam_active_session_timeout" {
  value       = module.account_settings.account_iam_active_session_timeout
  description = "Account Settings IAM Active Session Timeout"
}

output "account_iam_apikey_creation" {
  value       = module.account_settings.account_iam_apikey_creation
  description = "Account Settings IAM API Key Creation"
}

output "account_iam_inactive_session_timeout" {
  value       = module.account_settings.account_iam_inactive_session_timeout
  description = "Account Settings IAM Inactive Session Timeout"
}

output "account_iam_mfa" {
  value       = module.account_settings.account_iam_mfa
  description = "Account Settings IAM MFA"
}

output "account_iam_refresh_token_expiration" {
  value       = module.account_settings.account_iam_refresh_token_expiration
  description = "Account Settings IAM Refresh Token Expiration"
}

output "account_iam_serviceid_creation" {
  value       = module.account_settings.account_iam_serviceid_creation
  description = "Account Settings IAM Service ID Creation"
}

output "account_iam_user_mfa_list" {
  value       = module.account_settings.account_iam_user_mfa_list
  description = "Account Settings IAM User MFA List"
}

output "account_public_access" {
  value       = module.account_settings.account_public_access
  description = "Account Settings Public Access"
}

output "account_shell_settings_status" {
  value       = module.account_settings.account_shell_settings_status
  description = "Account Settings Shell Settings Status"
}

output "trusted_profile_projects" {
  value       = module.trusted_profile_projects.trusted_profile
  description = "Trusted Profile Projects Profile"
}

output "trusted_profile_projects_claim_rules" {
  value       = module.trusted_profile_projects.trusted_profile_claim_rules
  description = "Trusted Profile Projects Profile Claim Rules"
}

output "trusted_profile_projects_links" {
  value       = module.trusted_profile_projects.trusted_profile_links
  description = "Trusted Profile Projects Profile Links"
}

output "trusted_profile_projects_policies" {
  value       = module.trusted_profile_projects.trusted_profile_policies
  description = "Trusted Profile Projects Profile Policies"
}
