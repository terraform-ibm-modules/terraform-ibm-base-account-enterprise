########################################################################################################################
# Outputs
########################################################################################################################

output "security_resource_group_id" {
  value       = module.account_infrastructure_base.security_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "security_resource_group_name" {
  value       = module.account_infrastructure_base.security_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "audit_resource_group_id" {
  value       = module.account_infrastructure_base.audit_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "audit_resource_group_name" {
  value       = module.account_infrastructure_base.audit_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "observability_resource_group_id" {
  value       = module.account_infrastructure_base.observability_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "observability_resource_group_name" {
  value       = module.account_infrastructure_base.observability_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "management_resource_group_id" {
  value       = module.account_infrastructure_base.management_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "management_resource_group_name" {
  value       = module.account_infrastructure_base.management_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "workload_resource_group_id" {
  value       = module.account_infrastructure_base.workload_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "workload_resource_group_name" {
  value       = module.account_infrastructure_base.workload_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "edge_resource_group_id" {
  value       = module.account_infrastructure_base.edge_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "edge_resource_group_name" {
  value       = module.account_infrastructure_base.edge_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "devops_resource_group_id" {
  value       = module.account_infrastructure_base.devops_resource_group_id
  description = "ID of the Resource Group created by the module."
}

output "devops_resource_group_name" {
  value       = module.account_infrastructure_base.devops_resource_group_name
  description = "Name of the Resource Group created by the module."
}

output "activity_tracker_routes" {
  value       = module.account_infrastructure_base.activity_tracker_routes
  description = "Activity Tracker Routes"
}

output "activity_tracker_targets" {
  value       = module.account_infrastructure_base.activity_tracker_targets
  description = "Activity Tracker Targets"
}

output "cos_bucket" {
  value       = module.account_infrastructure_base.cos_bucket
  description = "COS Bucket"
}

output "cos_instance_guid" {
  value       = module.account_infrastructure_base.cos_instance_guid
  description = "COS Instance GUID"
}

output "cos_instance_id" {
  value       = module.account_infrastructure_base.cos_instance_id
  description = "COS Instance ID"
}

output "account_allowed_ip_addresses" {
  value       = module.account_infrastructure_base.account_allowed_ip_addresses
  description = "Account Settings Allowed IP Addresses"
}

output "account_allowed_ip_addresses_control_mode" {
  value       = module.account_infrastructure_base.account_allowed_ip_addresses_control_mode
  description = "Account Settings Allowed IP Addresses Control Mode"
}

output "account_allowed_ip_addresses_enforced" {
  value       = module.account_infrastructure_base.account_allowed_ip_addresses_enforced
  description = "Account Settings Allowed IP Addresses Enforced"
}

output "account_iam_access_token_expiration" {
  value       = module.account_infrastructure_base.account_iam_access_token_expiration
  description = "Account Settings IAM Access Token Expiration"
}

output "account_iam_active_session_timeout" {
  value       = module.account_infrastructure_base.account_iam_active_session_timeout
  description = "Account Settings IAM Active Session Timeout"
}

output "account_iam_apikey_creation" {
  value       = module.account_infrastructure_base.account_iam_apikey_creation
  description = "Account Settings IAM API Key Creation"
}

output "account_iam_inactive_session_timeout" {
  value       = module.account_infrastructure_base.account_iam_inactive_session_timeout
  description = "Account Settings IAM Inactive Session Timeout"
}

output "account_iam_mfa" {
  value       = module.account_infrastructure_base.account_iam_mfa
  description = "Account Settings IAM MFA"
}

output "account_iam_refresh_token_expiration" {
  value       = module.account_infrastructure_base.account_iam_refresh_token_expiration
  description = "Account Settings IAM Refresh Token Expiration"
}

output "account_iam_serviceid_creation" {
  value       = module.account_infrastructure_base.account_iam_serviceid_creation
  description = "Account Settings IAM Service ID Creation"
}

output "account_iam_user_mfa_list" {
  value       = module.account_infrastructure_base.account_iam_user_mfa_list
  description = "Account Settings IAM User MFA List"
}

output "account_public_access" {
  value       = module.account_infrastructure_base.account_public_access
  description = "Account Settings Public Access"
}

output "account_shell_settings_status" {
  value       = module.account_infrastructure_base.account_shell_settings_status
  description = "Account Settings Shell Settings Status"
}

output "trusted_profile_projects" {
  value       = module.account_infrastructure_base.trusted_profile_projects
  description = "Trusted Profile Projects Profile"
}

output "trusted_profile_projects_claim_rules" {
  value       = module.account_infrastructure_base.trusted_profile_projects_claim_rules
  description = "Trusted Profile Projects Profile Claim Rules"
}

output "trusted_profile_projects_links" {
  value       = module.account_infrastructure_base.trusted_profile_projects_links
  description = "Trusted Profile Projects Profile Links"
}

output "trusted_profile_projects_policies" {
  value       = module.account_infrastructure_base.trusted_profile_projects_policies
  description = "Trusted Profile Projects Profile Policies"
}

output "cbr_map_service_ref_name_zoneid" {
  value       = module.account_infrastructure_base.cbr_map_service_ref_name_zoneid
  description = "Map of service reference and zone ids"
}

output "cbr_map_target_service_rule_ids" {
  value       = module.account_infrastructure_base.cbr_map_target_service_rule_ids
  description = "Map of target service and rule ids"
}
