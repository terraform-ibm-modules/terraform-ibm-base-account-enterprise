########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region to provision the COS resources created by this solution."
  default     = "us-south"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this solution."
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the COS resources created by this solution."
  default     = []
}

variable "kms_key_crn" {
  type        = string
  description = "CRN of the KMS key to encrypt the COS bucket."
}

variable "cos_bucket_management_endpoint_type" {
  description = "The type of endpoint for the IBM terraform provider to use to manage the bucket. (public, private or direct)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private", "direct"], var.cos_bucket_management_endpoint_type)
    error_message = "The specified management_endpoint_type_for_bucket is not a valid selection!"
  }
}

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(string)
}

variable "access_groups" {
  description = "IAM Access Groups and policies"
  type = list(object({
    access_group_name = string
    provision         = optional(bool, true)
    add_members       = optional(bool, false)
    description       = optional(string, null)
    tags              = optional(list(string), null)
    ibm_ids           = optional(list(string), null)
    service_ids       = optional(list(string), null)

    policies = map(object({
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

    dynamic_rules = map(object({
      expiration        = number
      identity_provider = string
      conditions = list(object({
        claim    = string
        operator = string
        value    = string
      }))
    }))
  }))

  default = []
}

variable "custom_roles" {
  description = "IAM custom roles for Access Groups"
  type = list(object({
    name         = string
    service      = string
    display_name = string
    actions      = list(string)
    description  = optional(string, "")
  }))
  default = []
}
