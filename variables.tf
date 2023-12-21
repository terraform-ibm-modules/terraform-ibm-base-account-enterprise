########################################################################################################################
# Input Variables
########################################################################################################################

variable "region" {
  type        = string
  description = "Region of the resources created by the module."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources are created."
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long (seconds) a user is allowed to work continuously in the account"
  default     = 3600
}

variable "allowed_ip_addresses" {
  type        = list(any)
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  default     = []
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
  default     = "900"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT_SET' to unset account setting and use service default."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not"
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds"
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Enable global shell settings to all users in the account"
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var user_mfa"
  default     = false
}

variable "cos_instance_name" {
  type        = string
  description = "The name to give the cloud object storage instance that will be provisioned by this module."
}

variable "cos_bucket_name" {
  type        = string
  description = "The name to give the newly provisioned COS bucket."
}

variable "kms_encryption_enabled" {
  type        = bool
  description = "Set as true to use KMS key encryption to encrypt data in COS bucket"
  default     = false
}

variable "kms_key_crn" {
  type        = string
  description = "CRN of the KMS key to use to encrypt the data in the COS bucket."
  default     = null
}

variable "retention_enabled" {
  type        = bool
  description = "Retention enabled for COS bucket."
  default     = false
}

variable "retention_default" {
  description = "Specifies default duration of time an object that can be kept unmodified for COS bucket."
  type        = number
  default     = 90
}

variable "retention_maximum" {
  description = "Specifies maximum duration of time an object that can be kept unmodified for COS bucket."
  type        = number
  default     = 350
}

variable "retention_minimum" {
  description = "Specifies minimum duration of time an object must be kept unmodified for COS bucket."
  type        = number
  default     = 90
}

variable "retention_permanent" {
  description = "Specifies a permanent retention status either enable or disable for COS bucket."
  type        = bool
  default     = false
}

variable "cos_resource_key_name" {
  type        = string
  description = "Name of the resource key for COS instance."
}

variable "cos_target_name" {
  type        = string
  description = "Name of the COS Target for Activity Tracker."
}

variable "activity_tracker_route_name" {
  type        = string
  description = "Name of the route for the Activity Tracker."
}

variable "activity_tracker_locations" {
  type        = list(string)
  description = "Location of the route for the Activity Tracker."
}

variable "trusted_profile_name" {
  type        = string
  description = "Name of the trusted profile."
}

variable "trusted_profile_description" {
  type        = string
  description = "Description of the trusted profile."
  default     = "Trusted Profile for Projects access"
}

variable "trusted_profile_roles" {
  type        = list(string)
  description = "List of roles given to the trusted profile."
  default     = ["Administrator"]
}

variable "resource_tags" {
  type        = list(string)
  description = "A list of tags applied to resources created by the module."
  default     = null
}
