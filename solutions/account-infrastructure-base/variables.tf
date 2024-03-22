########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "trusted_profile_name" {
  type        = string
  description = "Name of the Trusted Profile used by Projects"
  default     = "account-infra-base-trusted-profile-projects"
}

variable "allowed_ip_addresses" {
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(string)
}
