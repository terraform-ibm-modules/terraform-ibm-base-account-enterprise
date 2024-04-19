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
  description = "Region to provision the COS resources created by this solution. Only required if 'provision_atracker_cos' is true."
  default     = "us-south"
  nullable    = false
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this solution."
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the COS resources created by this solution. Only required if 'provision_atracker_cos' is true."
  default     = []
}

variable "kms_key_crn" {
  type        = string
  description = "CRN of the KMS key to encrypt the COS bucket, required if 'var.provision_atracker_cos' is true."
  default     = null
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
  default     = []
}

variable "provision_atracker_cos" {
  type        = bool
  description = "Enable to create an Atracker route and COS instance + bucket."
  default     = false
}

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create."
  default     = null
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create."
  default     = null
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create. Required if `var.provision_atracker_cos` is true and `var.existing_cos_resource_group_name` is not provided."
  default     = null
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create."
  default     = null
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create."
  default     = null
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create."
  default     = null
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create."
  default     = null
}

variable "existing_cos_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to use for the COS instance/bucket, required if `var.provision_artacker_cos` is true and `var.observability_resource_group_name` is not provided."
  default     = null
}
