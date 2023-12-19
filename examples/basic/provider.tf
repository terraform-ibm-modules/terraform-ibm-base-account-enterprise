########################################################################################################################
# Provider config
########################################################################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

locals {
  at_endpoint = "https://api.${var.region}.logging.cloud.ibm.com"
}

provider "logdna" {
  alias      = "at"
  servicekey = data.ibm_resource_key.at_resource_key.credentials["service_key"] # module.basic_account.atracker.activity_tracker_resource_key
  url        = local.at_endpoint
}

provider "logdna" {
  alias      = "ld"
  servicekey = "" # data.ibm_resource_key.at_resource_key.credentials["service_key"] # module.basic_account.atracker.activity_tracker_resource_key
  url        = local.at_endpoint
}
