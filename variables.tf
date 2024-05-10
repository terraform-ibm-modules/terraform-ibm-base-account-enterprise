########################################################################################################################
# Account Variables
########################################################################################################################

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.security_resource_group_name, "null")) <= 40
    error_message = "`var.security_resource_group_name` must be 40 characters or less."
  }
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.audit_resource_group_name, "null")) <= 40
    error_message = "`var.audit_resource_group_name` must be 40 characters or less."
  }
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create. Required if `var.provision_atracker_cos` is true and `var.existing_cos_resource_group_name` is not provided."
  default     = null

  validation {
    condition     = length(coalesce(var.observability_resource_group_name, "null")) <= 40
    error_message = "`var.observability_resource_group_name` must be 40 characters or less."
  }
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.management_resource_group_name, "null")) <= 40
    error_message = "`var.management_resource_group_name` must be 40 characters or less."
  }
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.workload_resource_group_name, "null")) <= 40
    error_message = "`var.workload_resource_group_name` must be 40 characters or less."
  }
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.edge_resource_group_name, "null")) <= 40
    error_message = "`var.edge_resource_group_name` must be 40 characters or less."
  }
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.devops_resource_group_name, "null")) <= 40
    error_message = "`var.devops_resource_group_name` must be 40 characters or less."
  }
}

variable "existing_cos_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to use for the Object Storage instance and bucket. Required if `var.provision_artacker_cos` is true and `var.observability_resource_group_name` is not provided."
  default     = null
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long in seconds a user is allowed to work continuously in the account"
  default     = 86400
}

variable "allowed_ip_addresses" {
  type        = list(any)
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  default     = []
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the User API key creator role on the IAM Identity Service can create API keys, including the account owner. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "Whether the IP address restriction is enforced. If false, traffic originating outside of the specified allowed IP addresss is monitored with audit events sent to QRadar SIEM and Activity Tracker. After running in monitoring mode to test the impact of the restriction, you must set to true to enforce the IP allowlist."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "Define the maximum time it takes before an inactive user is signed out and their credentials are required again. The maximum duration a user can be inactive is 24 hours."
  default     = "7200"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "Define the number of login sessions that an account user can have active. Supports any whole number greater than '0', or 'NOT_SET' to unset account setting and use service default."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Whether to enable or disable the public access group. Assigning an access policy to the access group opens access to that resource to anyone whether they're a member of your account or not because authentication is no longer required. When set to false, the public access group is disabled."
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "Define the duration for how long refresh tokens are valid. The maximum duration you can set for a refresh token is 72 hours."
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the Service ID creator role on the IAM Identity Service can create service IDs, including the account owner. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Whether to allow CLI logins with only a password. Set to false for a higher level of security."
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Whether to delete all user MFA settings configured in the targeted account. Set to true to ignore entries declared in variable `user_mfa`."
  default     = false
}

########################################################################################################################
# IBM Cloud Object Storage Variables
########################################################################################################################

variable "provision_atracker_cos" {
  type        = bool
  description = "Whether to create an Activity Tracker route and Object Storage instance and bucket."
  default     = false
}

variable "region" {
  type        = string
  description = "Region to provision the Object Storage resources created by this solution."
  default     = "us-south"
}

variable "cos_plan" {
  type        = string
  description = "Pricing plan of the Object Storage instance created by the module."
  default     = "standard"
}

variable "cos_instance_name" {
  type        = string
  description = "The name for the Object Storage instance that this module provisions. Required if the variable `provision_atracker_cos` is true."
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "A list of tags applied to the Object Storage resources that are created by the module."
  default     = []
}

variable "cos_instance_access_tags" {
  type        = list(string)
  description = "A list of access tags applied to the created Object Storage instance."
  default     = []
}

variable "cos_bucket_name" {
  type        = string
  description = "The name for the newly provisioned Object Storage bucket that is used store Activity Tracker logs. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "cos_bucket_access_tags" {
  type        = list(string)
  description = "A list of access tags applied to the created Object Storage bucket."
  default     = []
}

variable "cos_bucket_expire_enabled" {
  type        = bool
  description = "Whether to enable the expiration rule on the Object Storage bucket. Specify the number of days in the variable `cos_bucket_expire_days`."
  default     = false
}

variable "cos_bucket_expire_days" {
  type        = number
  description = "Number of days before objects in a Object Storage bucket are automatically deleted."
  default     = 365
}

variable "cos_bucket_object_versioning_enabled" {
  type        = bool
  description = "Whether to enable versioning on the bucket."
  default     = false
}

variable "kms_key_crn" {
  type        = string
  description = "Cloud Resource Name (CRN) of the key management service key used to encrypt the data in the Object Storage bucket. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "cos_bucket_management_endpoint_type" {
  description = "The type of endpoint that the IBM terraform provider uses to manage the bucket. Suppodted values are `public`, `private` or `direct`."
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private", "direct"], var.cos_bucket_management_endpoint_type)
    error_message = "The specified management_endpoint_type_for_bucket is not a valid selection."
  }
}

variable "cos_bucket_storage_class" {
  type        = string
  description = "Object Storage bucket storage class type."
  default     = null
}

variable "cos_bucket_archive_enabled" {
  type        = bool
  description = "Whether to enable archiving on the Object Storage bucket."
  default     = false
}

variable "cos_bucket_archive_days" {
  type        = number
  description = "Number of days before objects in the bucket are archived."
  default     = 20
}

variable "cos_bucket_archive_type" {
  type        = string
  description = "Type of archiving to use on the bucket."
  default     = "Glacier"
}

variable "cos_bucket_retention_enabled" {
  type        = bool
  description = "Whether to enable retention for the Object Storage bucket."
  default     = false
}

variable "cos_bucket_retention_default" {
  description = "Specifies default duration of time an object that can be kept unmodified for Object Storagebucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_maximum" {
  description = "Specifies maximum duration of time in days that an object that can be kept unmodified for a Object Storage bucket."
  type        = number
  default     = 350
}

variable "cos_bucket_retention_minimum" {
  description = "Specifies minimum duration of time in days that an object must be kept unmodified for Object Storage bucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_permanent" {
  description = "Whether to enable a permanent retention status for the Object Storage bucket."
  type        = bool
  default     = false
}

variable "cos_bucket_cbr_rules" {
  type = list(object({
    description = string
    account_id  = string
    rule_contexts = list(object({
      attributes = optional(list(object({
        name  = string
        value = string
      })))
    }))
    enforcement_mode = string
    tags = optional(list(object({
      name  = string
      value = string
    })), [])
    operations = optional(list(object({
      api_types = list(object({
        api_type_id = string
      }))
    })))
  }))
  description = "Context-based restriciton rules for the Object Storage bucket"
  default     = []
}

variable "cos_instance_cbr_rules" {
  type = list(object({
    description = string
    account_id  = string
    rule_contexts = list(object({
      attributes = optional(list(object({
        name  = string
        value = string
      })))
    }))
    enforcement_mode = string
    tags = optional(list(object({
      name  = string
      value = string
    })), [])
    operations = optional(list(object({
      api_types = list(object({
        api_type_id = string
      }))
    })))
  }))
  description = "Context-based restriction rules for the Object Storage instance."
  default     = []
}

########################################################################################################################
# Activity Tracker Variables
########################################################################################################################

variable "skip_atracker_cos_iam_auth_policy" {
  type        = bool
  description = "Whether to skip creating an IAM authorization policy that grants the Activity Tracker service Object Writer access to the Object Storage instance that is provisioned by this module. If set to true, you must ensure the authorization policy exists on the account before running the module."
  default     = false
}

variable "cos_target_name" {
  type        = string
  description = "Name of the Object Storage target for Activity Tracker. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "activity_tracker_route_name" {
  type        = string
  description = "Name of the route for the Activity Tracker. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "activity_tracker_locations" {
  type        = list(string)
  description = "Location of the route for the Activity Tracker. Logs from these locations are sent to the specified target. Supports passing individual regions, as well as `global` and `*`."
  default     = ["*", "global"]
}

########################################################################################################################
# Trusted Profile Variables
########################################################################################################################

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
