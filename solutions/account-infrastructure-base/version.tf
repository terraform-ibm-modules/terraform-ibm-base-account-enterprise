terraform {
  required_version = ">= 1.0.0"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.70.1"
    }
    logdna = {
      source  = "logdna/logdna"
      version = "1.16.0"
    }
  }
}
