########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key that is used by the provider to authenticate with IBM Cloud to create the resources."
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The region to provision the Object Storage resources created by this solution. Only required if `provision_atracker_cos` is true."
  default     = "us-south"
  nullable    = false
}

variable "prefix" {
  type        = string
  description = "An optional prefix to append to all resources created by this solution."
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "An optional list of tags to be added to the Object Storage resources created by this solution. Required only if `provision_atracker_cos` is true."
  default     = []
}

variable "kms_key_crn" {
  type        = string
  description = "The CRN of the key management service key to encrypt the Object Storage bucket. Required if `provision_atracker_cos` is true."
  default     = null
}

variable "cos_bucket_management_endpoint_type" {
  description = "The type of endpoint for the IBM terraform provider to use to manage the bucket. (public, private or direct)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private", "direct"], var.cos_bucket_management_endpoint_type)
    error_message = "The specified management_endpoint_type_for_bucket is not a valid selection."
  }
}

variable "allowed_ip_addresses" {
  description = " A list of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(string)
  default     = []
}

variable "provision_atracker_cos" {
  type        = bool
  description = "Whether to enable creating an Activity Tracker route, Object Storage instance, and bucket."
  default     = false
}

variable "skip_cos_kms_auth_policy" {
  type        = bool
  description = "Whether to enable creating an IAM authoriation policy between the IBM Cloud Object Storage instance and the Key Management service instance of the CRN provided in `var.kms_key_crn`. This variable has no effect if `var.provision_atracker_cos` is false."
  default     = false
}

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create. If `var.prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<security_resource_group_name>`."
  default     = null
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<audit_resource_group_name>`."
  default     = null
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create. Required if `provision_atracker_cos` is true and `existing_cos_resource_group_name` is not provided. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<observability_resource_group_name>`."
  default     = null
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<management_resource_group_name>`."
  default     = null
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<workload_resource_group_name>`."
  default     = null
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<edge_resource_group_name>`."
  default     = null
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<devops_resource_group_name>`."
  default     = null
}

variable "existing_cos_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to use for the Object Storage instance and bucket. Required if `provision_artacker_cos` is true and `observability_resource_group_name` is not provided."
  default     = null
}

variable "access_token_expiration" {
  type        = string
  description = "The access token expiration in seconds."
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long in seconds a user is allowed to work continuously in the account."
  default     = 86400
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the User API key creator role on the IAM Identity Service can create API keys, including the account owner. Allowed values are `restricted`, `not_restricted`, or `not_set` (to clear a previous value)."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "Whether the IP address restriction is enforced. If `false`, traffic originating outside of the specified allowed IP addresss is monitored with audit events sent to QRadar SIEM and Activity Tracker. After running in monitoring mode to test the impact of the restriction, you must set to `true` to enforce the IP allowlist."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "The maximum time in seconds before an inactive user is signed out and their credentials are required again. The maximum duration a user can be inactive is 24 hours."
  default     = "7200"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "The number of login sessions that an account user can have active. Supports any whole number greater than `0`, or `NOT_SET` to unset account setting and use service default."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "The Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Whether to enable or disable the public access group. Assigning an access policy to the access group opens access to that resource to anyone whether they're a member of your account or not because authentication is no longer required. When set to false, the public access group is disabled."
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "The duration for how long refresh tokens are valid. The maximum duration you can set for a refresh token is 72 hours."
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the Service ID creator role on the IAM Identity Service can create service IDs, including the account owner. Allowed values are `restricted`, `not_restricted`, or `not_set` (to clear a previous value)."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Whether to allow CLI logins with only a password. Set to false for a higher level of security."
  default     = false
}

variable "skip_cloud_shell_calls" {
  type        = bool
  description = "Skip Cloud Shell calls in the account."
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Multi-Factor Authentication method for specific users the account. Supported valid values are `NONE` (No MFA trait set), `TOTP` (For all non-federated IBMId users), `TOTP4ALL` (For all users), `LEVEL1` (Email based MFA for all users), `LEVEL2` (TOTP based MFA for all users), `LEVEL3` (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Whether to delete all user MFA settings configured in the targeted account. Set to true to ignore entries declared in variable `user_mfa`."
  default     = false
}

variable "cos_plan" {
  type        = string
  description = "The pricing plan of the Object Storage instance created by the module."
  default     = "standard"
}

variable "cos_instance_name" {
  type        = string
  description = "The name for the Object Storage instance that this module provisions. Required if the variable `provision_atracker_cos` is true."
  default     = null
}

variable "cos_instance_access_tags" {
  type        = list(string)
  description = "A list of access tags applied to the Object Storage instance that this module provisions."
  default     = []
}

variable "cos_bucket_name" {
  type        = string
  description = "The name for the Object Storage bucket that stores Activity Tracker logs. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "cos_bucket_access_tags" {
  type        = list(string)
  description = "A list of access tags applied to the Object Storage bucket that this module provisions."
  default     = []
}

variable "cos_bucket_expire_enabled" {
  type        = bool
  description = "Whether to enable the expiration rule on the Object Storage bucket. Specify the number of days in the variable `cos_bucket_expire_days`."
  default     = false
}

variable "cos_bucket_expire_days" {
  type        = number
  description = "The number of days before objects in a Object Storage bucket are automatically deleted."
  default     = 365
}

variable "cos_bucket_object_versioning_enabled" {
  type        = bool
  description = "Whether to enable versioning on the bucket."
  default     = false
}

variable "cos_bucket_storage_class" {
  type        = string
  description = "The Object Storage bucket storage class type."
  default     = null
}

variable "cos_bucket_archive_enabled" {
  type        = bool
  description = "Whether to enable archiving on the Object Storage bucket."
  default     = false
}

variable "cos_bucket_archive_days" {
  type        = number
  description = "The number of days before objects in the bucket are archived."
  default     = 20
}

variable "cos_bucket_archive_type" {
  type        = string
  description = "The type of archiving to use on the bucket."
  default     = "Glacier"
}

variable "cos_bucket_retention_enabled" {
  type        = bool
  description = "Whether to enable retention for the Object Storage bucket."
  default     = false
}

variable "cos_bucket_retention_default" {
  description = "The default duration of time that an object can be kept unmodified in an Object Storage bucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_maximum" {
  description = "The maximum duration of time that an object can be kept unmodified in an Object Storage bucket."
  type        = number
  default     = 350
}

variable "cos_bucket_retention_minimum" {
  description = "The minimum duration of time in days that an object must be kept unmodified for Object Storage bucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_permanent" {
  description = "Whether to enable a permanent retention status for the Object Storage bucket."
  type        = bool
  default     = false
}

variable "skip_atracker_cos_iam_auth_policy" {
  type        = bool
  description = "Whether to skip creating an IAM authorization policy that grants the Activity Tracker service Object Writer access to the Object Storage instance that is provisioned by this module. If set to true, you must ensure the authorization policy exists on the account before running the module."
  default     = false
}

variable "cos_target_name" {
  type        = string
  description = "The name of the Object Storage target for Activity Tracker. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "activity_tracker_route_name" {
  type        = string
  description = "The name of the route for Activity Tracker. Required if variable `provision_atracker_cos` is true."
  default     = null
}

variable "activity_tracker_locations" {
  type        = list(string)
  description = "The location of the route for Activity Tracker. Logs from these locations are sent to the specified target. Supports passing individual regions, `global`, and `*`."
  default     = ["*", "global"]
}

variable "provision_trusted_profile_projects" {
  type        = bool
  description = "Whether the trusted profile for Projects is provisioned."
  default     = true
}

variable "trusted_profile_name" {
  type        = string
  description = "The name of the trusted profile. Required if `provision_trusted_profile_projects` is true."
  default     = null
}

variable "trusted_profile_description" {
  type        = string
  description = "The description of the trusted profile."
  default     = "Trusted Profile for Projects access"
}

variable "trusted_profile_roles" {
  type        = list(string)
  description = "A list of roles given to the trusted profile."
  default     = ["Administrator"]
}

########################################################################################################################
# Access Management Variables
########################################################################################################################

variable "provision_access_management" {
  type        = bool
  description = "Whether to enable provisioning of Access Managment access groups in the account. Default is true."
  default     = true
}

##############################################################################
# Admin Observability Variables
##############################################################################

variable "admin_observability_ag_name" {
  type        = string
  description = "Name of the Administrator Observability access group"
  default     = null
}

variable "admin_observability_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Administrator Observability access group, has a set of default policies that can be overridden"
  default     = null
}

variable "admin_observability_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the admin observability access group"
  default     = null
}

variable "admin_observability_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the admin observability group"
  default     = false
}

variable "admin_observability_ag_description" {
  type        = string
  description = "Description of the admin observability access group"
  default     = null
}

variable "admin_observability_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your admin observability access group"
  default     = null
}

variable "admin_observability_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs that you want to add to the admin observability access group"
  default     = null
}

variable "admin_observability_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs that you want to add to the admin observability access group"
  default     = null
}

##############################################################################
# Admin Security Variables
##############################################################################

variable "admin_security_ag_name" {
  type        = string
  description = "Name of the Administrator Security access group"
  default     = null
}

variable "admin_security_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Administrator Security access group, has a set of default policies that can be overridden"
  default     = null
}

variable "admin_security_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the admin security access group"
  default     = null
}

variable "admin_security_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the admin security group"
  default     = false
}

variable "admin_security_ag_description" {
  type        = string
  description = "Description of the admin security access group"
  default     = null
}

variable "admin_security_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your admin security access group"
  default     = null
}

variable "admin_security_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs that you want to add to the admin security access group"
  default     = null
}

variable "admin_security_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs that you want to add to the admin security access group"
  default     = null
}

##############################################################################
# Admin Network Variables
##############################################################################

variable "admin_network_ag_name" {
  type        = string
  description = "Name of the Administrator Network access group"
  default     = null
}

variable "admin_network_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Administrator Network access group, has a set of default policies that can be overridden"
  default     = null
}

variable "admin_network_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the admin network access group"
  default     = null
}

variable "admin_network_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the admin network group"
  default     = false
}

variable "admin_network_ag_description" {
  type        = string
  description = "Description of the admin network access group"
  default     = null
}

variable "admin_network_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your admin network access group"
  default     = null
}

variable "admin_network_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs that you want to add to the admin network access group"
  default     = null
}

variable "admin_network_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs that you want to add to the admin network access group"
  default     = null
}

##############################################################################
# Admin Compute Services Variables
##############################################################################

variable "admin_compute_ag_name" {
  type        = string
  description = "Name of the Administrator Compute access group"
  default     = null
}

variable "admin_compute_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Administrator Compute access group, has a set of default policies that can be overridden"
  default     = null
}

variable "admin_compute_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the admin compute access group"
  default     = null
}

variable "admin_compute_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the admin compute group"
  default     = false
}

variable "admin_compute_ag_description" {
  type        = string
  description = "Description of the admin compute access group"
  default     = null
}

variable "admin_compute_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your admin compute access group"
  default     = null
}

variable "admin_compute_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the admin compute access group"
  default     = null
}

variable "admin_compute_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the admin compute access group"
  default     = null
}

##############################################################################
# Privileged Observability Services Variables
##############################################################################

variable "privileged_observability_ag_name" {
  type        = string
  description = "Name of the Privileged Observability access group"
  default     = null
}

variable "privileged_observability_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Privileged Observability access group, has a set of default policies that can be overridden"
  default     = null
}

variable "privileged_observability_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the privileged observability access group"
  default     = null
}

variable "privileged_observability_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the privileged observability group"
  default     = false
}

variable "privileged_observability_ag_description" {
  type        = string
  description = "Description of the privileged observability access group"
  default     = null
}

variable "privileged_observability_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your privileged observability access group"
  default     = null
}

variable "privileged_observability_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the privileged observability access group"
  default     = null
}

variable "privileged_observability_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the privileged observability access group"
  default     = null
}

##############################################################################
# Privileged Security Services Variables
##############################################################################

variable "privileged_security_ag_name" {
  type        = string
  description = "Name of the Privileged Security access group"
  default     = null
}

variable "privileged_security_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Privileged Security access group, has a set of default policies that can be overridden"
  default     = null
}

variable "privileged_security_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the privileged security access group"
  default     = null
}

variable "privileged_security_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the privileged security group"
  default     = false
}

variable "privileged_security_ag_description" {
  type        = string
  description = "Description of the privileged security access group"
  default     = null
}

variable "privileged_security_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your privileged security access group"
  default     = null
}

variable "privileged_security_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the privileged security access group"
  default     = null
}

variable "privileged_security_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the privileged security access group"
  default     = null
}

##############################################################################
# Privileged Network Services Variables
##############################################################################

variable "privileged_network_ag_name" {
  type        = string
  description = "Name of the Privileged Observability access group"
  default     = null
}

variable "privileged_network_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Privileged Network access group, has a set of default policies that can be overridden"
  default     = null
}

variable "privileged_network_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the privileged network access group"
  default     = null
}

variable "privileged_network_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the privileged network group"
  default     = false
}

variable "privileged_network_ag_description" {
  type        = string
  description = "Description of the privileged network access group"
  default     = null
}

variable "privileged_network_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your privileged network access group"
  default     = null
}

variable "privileged_network_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the privileged network access group"
  default     = null
}

variable "privileged_network_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the privileged network access group"
  default     = null
}

##############################################################################
# Privileged Compute Services Variables
##############################################################################

variable "privileged_compute_ag_name" {
  type        = string
  description = "Name of the Privileged Compute access group"
  default     = null
}

variable "privileged_compute_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Privileged Compute access group, has a set of default policies that can be overridden"
  default     = null
}

variable "privileged_compute_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the privileged compute access group"
  default     = null
}

variable "privileged_compute_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the privileged compute group"
  default     = false
}

variable "privileged_compute_ag_description" {
  type        = string
  description = "Description of the privileged compute access group"
  default     = null
}

variable "privileged_compute_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your privileged compute access group"
  default     = null
}

variable "privileged_compute_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the privileged compute access group"
  default     = null
}

variable "privileged_compute_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the privileged compute access group"
  default     = null
}

##############################################################################
# Observer Observability Services Variables
##############################################################################

variable "observer_observability_ag_name" {
  type        = string
  description = "Name of the Observer Observability access group"
  default     = null
}

variable "observer_observability_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Observer Observability access group, has a set of default policies that can be overridden"
  default     = null
}

variable "observer_observability_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the observer observability access group"
  default     = null
}

variable "observer_observability_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the observer observability group"
  default     = false
}

variable "observer_observability_ag_description" {
  type        = string
  description = "Description of the observer observability access group"
  default     = null
}

variable "observer_observability_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your observer observability access group"
  default     = null
}

variable "observer_observability_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the observer observability access group"
  default     = null
}

variable "observer_observability_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the observer observability access group"
  default     = null
}

##############################################################################
# Observer Security Services Variables
##############################################################################

variable "observer_security_ag_name" {
  type        = string
  description = "Name of the Observer Security access group"
  default     = null
}

variable "observer_security_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Observer Security access group, has a set of default policies that can be overridden"
  default     = null
}

variable "observer_security_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the observer security access group"
  default     = null
}

variable "observer_security_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the observer security group"
  default     = false
}

variable "observer_security_ag_description" {
  type        = string
  description = "Description of the observer security access group"
  default     = null
}

variable "observer_security_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your observer security access group"
  default     = null
}

variable "observer_security_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the observer security access group"
  default     = null
}

variable "observer_security_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the observer security access group"
  default     = null
}

##############################################################################
# Observer Network Services Variables
##############################################################################

variable "observer_network_ag_name" {
  type        = string
  description = "Name of the Observer Network access group"
  default     = null
}

variable "observer_network_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Observer Network access group, has a set of default policies that can be overridden"
  default     = null
}

variable "observer_network_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the observer network access group"
  default     = null
}

variable "observer_network_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the observer network group"
  default     = false
}

variable "observer_network_ag_description" {
  type        = string
  description = "Description of the observer network access group"
  default     = null
}

variable "observer_network_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your observer network access group"
  default     = null
}

variable "observer_network_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the observer network access group"
  default     = null
}

variable "observer_network_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the observer network access group"
  default     = null
}

##############################################################################
# Observer Compute Services Variables
##############################################################################

variable "observer_compute_ag_name" {
  type        = string
  description = "Name of the Observer Compute access group"
  default     = null
}

variable "observer_compute_ag_policies" {
  type = map(object({
    roles              = list(string)
    account_management = optional(bool)
    tags               = set(string)
    resources = optional(list(object({
      region               = optional(string)
      attributes           = optional(map(string))
      service              = optional(string)
      resource_instance_id = optional(string)
      resource_type        = optional(string)
      resource             = optional(string)
      resource_group_id    = optional(string)
    })))
    resource_attributes = optional(list(object({
      name     = string
      value    = string
      operator = optional(string)
    })))
  }))
  description = "A map of policies for the Observer Compute access group, has a set of default policies that can be overridden"
  default     = null
}

variable "observer_compute_ag_dynamic_rules" {
  type = map(object({
    expiration        = number
    identity_provider = string
    conditions = list(object({
      claim    = string
      operator = string
      value    = string
    }))
  }))
  description = "A map of dynamic rules for the observer compute access group"
  default     = null
}

variable "observer_compute_ag_add_members" {
  type        = bool
  description = "Enable this to add members to the observer compute group"
  default     = false
}

variable "observer_compute_ag_description" {
  type        = string
  description = "Description of the observer compute access group"
  default     = null
}

variable "observer_compute_ag_tags" {
  type        = list(string)
  description = "The list of tags that you want to associated with your observer compute access group"
  default     = null
}

variable "observer_compute_ag_ibm_ids" {
  type        = list(string)
  description = "A list of IBM IDs you want to add to the observer compute access group"
  default     = null
}

variable "observer_compute_ag_service_ids" {
  type        = list(string)
  description = "A list of Service IDs you want to add to the observer compute access group"
  default     = null
}
