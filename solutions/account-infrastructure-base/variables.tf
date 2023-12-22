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
  description = "Region of the COS resources created in the DA."
  default     = "us-south"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to the COS resources"
  default     = []
}

variable "kms_guid" {
  type        = string
  description = "GUID of the KMS instance where the key is located."
}

variable "kms_key_crn" {
  type        = string
  description = "CRN of the KMS key to encrypt the COS bucket."
}
