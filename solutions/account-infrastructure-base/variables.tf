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
  default     = null
}

variable "provision_atracker_cos" {
  type        = bool
  description = "Enable to create an Atracker route and COS instance + bucket."
  default     = false
}

variable "cbr_allow_cos_to_kms" {
  type        = bool
  description = "Set rule for COS to KMS, default is true"
  default     = true
}

variable "cbr_allow_block_storage_to_kms" {
  type        = bool
  description = "Set rule for block storage to KMS, default is true"
  default     = true
}

variable "cbr_allow_roks_to_kms" {
  type        = bool
  description = "Set rule for ROKS to KMS, default is true"
  default     = true
}

variable "cbr_allow_icd_to_kms" {
  type        = bool
  description = "Set rule for ICD to KMS, default is true"
  default     = true
}

variable "cbr_allow_event_streams_to_kms" {
  type        = bool
  description = "Set rule for Event Streams (Messagehub) to KMS, default is true"
  default     = true
}

variable "cbr_allow_vpcs_to_container_registry" {
  type        = bool
  description = "Set rule for VPCs to container registry, default is true"
  default     = true
}

variable "cbr_allow_vpcs_to_cos" {
  type        = bool
  description = "Set rule for VPCs to COS, default is true"
  default     = true
}

variable "cbr_allow_at_to_cos" {
  type        = bool
  description = "Set rule for Activity Tracker to COS, default is true"
  default     = true
}

variable "cbr_allow_iks_to_is" {
  type        = bool
  description = "Set rule for IKS to IS (VPC Infrastructure Services), default is true"
  default     = true
}

variable "cbr_allow_is_to_cos" {
  type        = bool
  description = "Set rule for IS (VPC Infrastructure Services) to COS, default is true"
  default     = true
}
