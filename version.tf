terraform {
  required_version = ">= 1.0.0"
  # If your module requires any terraform providers, uncomment the "required_providers" section below and add all required providers.
  # Each required provider's version should be a flexible range to future proof the module's usage with upcoming minor and patch versions.

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.64.1, < 2.0.0"
    }
    logdna = {
      source                = "logdna/logdna"
      version               = ">= 1.14.2, < 2.0.0"
      configuration_aliases = [logdna.at, logdna.ld]
    }
  }
}
