# Terraform IBM Base Account Enterprise

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-base-account-enterprise?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-base-account-enterprise/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
This module is a general base layer module for setting up a newly provisioned enterprise account with a default provision of:

- Base Resource Group
- IAM Account Settings
- Activity Tracker routing + COS Bucket
- Trusted Profile + Access Group for Projects

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-base-account-enterprise](#terraform-ibm-base-account-enterprise)
* [Examples](./examples)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and links to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in Authoring Guidelines in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- This heading should always match the name of the root level module (aka the repo name) -->
## terraform-ibm-base-account-enterprise

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
locals {
  at_endpoint = "https://api.us-south.logging.cloud.ibm.com"
}

provider "logdna" {
  alias      = "at"
  servicekey = ""
  url        = local.at_endpoint
}

provider "logdna" {
  alias      = "ld"
  servicekey = ""
  url        = local.at_endpoint
}

module "enterprise_account" {
    source  = "terraform-ibm-modules/base-account-enterprise/ibm"
    version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
    providers = { # providers block necessary for logdna provider aliases
        logdna.at = logdna.at
        logdna.ld = logdna.ld
    }
    region                      = "us-south"
    resource_group_name         = "base-enterprise-resource-group"
    cos_instance_name           = "base-enterprise-cos-instance"
    cos_bucket_name             = "base-enterprise-cos-bucket"
    cos_resource_key_name       = "base-enterprise-cos-key"
    cos_target_name             = "base-enterprise-cos-target"
    trusted_profile_name        = "base-enterprise-trusted-profile"
    activity_tracker_locations  = ["us-south", "global"]
    activity_tracker_route_name = "base-enterprise-route"
    resource_tags               = ["base-enterprise"]
}
```

### Required IAM access policies

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

You need the following permissions to run this module.

- Account Management
    - **All Account Management** services
        - `Administrator` platform access
    - IAM Services
        - **Cloud Object Storage** service
            - `Editor` platform access
            - `Manager` service access
        - **Activity Tracker** service
            - `Administrator` platform access
            - `Writer` service access

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.53.0, < 2.0.0 |
| <a name="requirement_logdna"></a> [logdna](#requirement\_logdna) | >= 1.14.2, < 2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_settings"></a> [account\_settings](#module\_account\_settings) | terraform-ibm-modules/iam-account-settings/ibm | 2.5.0 |
| <a name="module_activity_tracker"></a> [activity\_tracker](#module\_activity\_tracker) | terraform-ibm-modules/observability-instances/ibm//modules/activity_tracker | 2.10.1 |
| <a name="module_cos"></a> [cos](#module\_cos) | terraform-ibm-modules/cos/ibm//modules/fscloud | 7.0.7 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.4 |
| <a name="module_trusted_profile_projects"></a> [trusted\_profile\_projects](#module\_trusted\_profile\_projects) | terraform-ibm-modules/trusted-profile/ibm | 1.0.1 |

### Resources

| Name | Type |
|------|------|
| [ibm_resource_key.cos_resource_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_key) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuously in the account | `number` | `3600` | no |
| <a name="input_activity_tracker_locations"></a> [activity\_tracker\_locations](#input\_activity\_tracker\_locations) | Location of the route for the Activity Tracker, logs from these locations will be sent to the specified target. Supports passing individual regions, as well as `global` and `*`. | `list(string)` | <pre>[<br>  "*",<br>  "global"<br>]</pre> | no |
| <a name="input_activity_tracker_route_name"></a> [activity\_tracker\_route\_name](#input\_activity\_tracker\_route\_name) | Name of the route for the Activity Tracker. | `string` | n/a | yes |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets from which IAM tokens can be created for the account. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_cos_bucket_access_tags"></a> [cos\_bucket\_access\_tags](#input\_cos\_bucket\_access\_tags) | A list of Access Tags applied to the created bucket. | `list(string)` | `[]` | no |
| <a name="input_cos_bucket_archive_days"></a> [cos\_bucket\_archive\_days](#input\_cos\_bucket\_archive\_days) | Number of days to archive objects in the bucket. | `number` | `20` | no |
| <a name="input_cos_bucket_archive_enabled"></a> [cos\_bucket\_archive\_enabled](#input\_cos\_bucket\_archive\_enabled) | Set as true to enable archiving on the COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_archive_type"></a> [cos\_bucket\_archive\_type](#input\_cos\_bucket\_archive\_type) | Type of archiving to use on bucket. | `string` | `"Glacier"` | no |
| <a name="input_cos_bucket_cbr_rules"></a> [cos\_bucket\_cbr\_rules](#input\_cos\_bucket\_cbr\_rules) | COS Bucket CBR Rules | <pre>list(object({<br>    description = string<br>    account_id  = string<br>    rule_contexts = list(object({<br>      attributes = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>    }))<br>    enforcement_mode = string<br>    tags = optional(list(object({<br>      name  = string<br>      value = string<br>    })), [])<br>    operations = optional(list(object({<br>      api_types = list(object({<br>        api_type_id = string<br>      }))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_cos_bucket_expire_days"></a> [cos\_bucket\_expire\_days](#input\_cos\_bucket\_expire\_days) | Number of days before expiry. | `number` | `365` | no |
| <a name="input_cos_bucket_expire_enabled"></a> [cos\_bucket\_expire\_enabled](#input\_cos\_bucket\_expire\_enabled) | A flag to control expiry rule on the bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_management_endpoint_type"></a> [cos\_bucket\_management\_endpoint\_type](#input\_cos\_bucket\_management\_endpoint\_type) | Management endpoint of the COS bucket. | `string` | n/a | yes |
| <a name="input_cos_bucket_name"></a> [cos\_bucket\_name](#input\_cos\_bucket\_name) | The name to give the newly provisioned COS bucket which will be used for Activity Tracker logs. | `string` | n/a | yes |
| <a name="input_cos_bucket_object_versioning_enabled"></a> [cos\_bucket\_object\_versioning\_enabled](#input\_cos\_bucket\_object\_versioning\_enabled) | A flag to control object versioning on the bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_retention_default"></a> [cos\_bucket\_retention\_default](#input\_cos\_bucket\_retention\_default) | Specifies default duration of time an object that can be kept unmodified for COS bucket. | `number` | `90` | no |
| <a name="input_cos_bucket_retention_enabled"></a> [cos\_bucket\_retention\_enabled](#input\_cos\_bucket\_retention\_enabled) | Retention enabled for COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_retention_maximum"></a> [cos\_bucket\_retention\_maximum](#input\_cos\_bucket\_retention\_maximum) | Specifies maximum duration of time an object that can be kept unmodified for COS bucket. | `number` | `350` | no |
| <a name="input_cos_bucket_retention_minimum"></a> [cos\_bucket\_retention\_minimum](#input\_cos\_bucket\_retention\_minimum) | Specifies minimum duration of time an object must be kept unmodified for COS bucket. | `number` | `90` | no |
| <a name="input_cos_bucket_retention_permanent"></a> [cos\_bucket\_retention\_permanent](#input\_cos\_bucket\_retention\_permanent) | Specifies a permanent retention status either enable or disable for COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_storage_class"></a> [cos\_bucket\_storage\_class](#input\_cos\_bucket\_storage\_class) | COS Bucket storage class type | `string` | `null` | no |
| <a name="input_cos_create_hmac_key"></a> [cos\_create\_hmac\_key](#input\_cos\_create\_hmac\_key) | Enable to create the HMAC key for the COS instance. | `bool` | `true` | no |
| <a name="input_cos_hmac_key_name"></a> [cos\_hmac\_key\_name](#input\_cos\_hmac\_key\_name) | Name of the resource key for COS instance. | `string` | `"hmac-cos-key"` | no |
| <a name="input_cos_hmac_key_role"></a> [cos\_hmac\_key\_role](#input\_cos\_hmac\_key\_role) | The role you want to be associated with your new hmac key. Valid roles are 'Writer', 'Reader', 'Manager', 'Content Reader', 'Object Reader', 'Object Writer'. | `string` | `"Manager"` | no |
| <a name="input_cos_instance_cbr_rules"></a> [cos\_instance\_cbr\_rules](#input\_cos\_instance\_cbr\_rules) | CBR Rules for the COS instance. | <pre>list(object({<br>    description = string<br>    account_id  = string<br>    rule_contexts = list(object({<br>      attributes = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>    }))<br>    enforcement_mode = string<br>    tags = optional(list(object({<br>      name  = string<br>      value = string<br>    })), [])<br>    operations = optional(list(object({<br>      api_types = list(object({<br>        api_type_id = string<br>      }))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_cos_instance_name"></a> [cos\_instance\_name](#input\_cos\_instance\_name) | The name to give the cloud object storage instance that will be provisioned by this module. | `string` | n/a | yes |
| <a name="input_cos_plan"></a> [cos\_plan](#input\_cos\_plan) | Plan of the COS instance created by the module | `string` | `"standard"` | no |
| <a name="input_cos_target_name"></a> [cos\_target\_name](#input\_cos\_target\_name) | Name of the COS Target for Activity Tracker. | `string` | n/a | yes |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing. | `bool` | `true` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle | `string` | `"900"` | no |
| <a name="input_kms_encryption_enabled"></a> [kms\_encryption\_enabled](#input\_kms\_encryption\_enabled) | Set as true to use KMS key encryption to encrypt data in COS bucket | `bool` | `false` | no |
| <a name="input_kms_guid"></a> [kms\_guid](#input\_kms\_guid) | GUID of the KMS instance where the provided key is taken from. | `string` | n/a | yes |
| <a name="input_kms_key_crn"></a> [kms\_key\_crn](#input\_kms\_key\_crn) | CRN of the KMS key to use to encrypt the data in the COS bucket. | `string` | n/a | yes |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT\_SET' to unset account setting and use service default. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). | `string` | `"TOTP4ALL"` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds | `string` | `"259200"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of the COS resources created by the module. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create. All resources provisioned by this module will be provisioned to this group. | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | A list of tags applied to the COS resources created by the module. | `list(string)` | `[]` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Enable global shell settings to all users in the account | `bool` | `false` | no |
| <a name="input_trusted_profile_description"></a> [trusted\_profile\_description](#input\_trusted\_profile\_description) | Description of the trusted profile. | `string` | `"Trusted Profile for Projects access"` | no |
| <a name="input_trusted_profile_name"></a> [trusted\_profile\_name](#input\_trusted\_profile\_name) | Name of the trusted profile. | `string` | n/a | yes |
| <a name="input_trusted_profile_roles"></a> [trusted\_profile\_roles](#input\_trusted\_profile\_roles) | List of roles given to the trusted profile. | `list(string)` | <pre>[<br>  "Administrator"<br>]</pre> | no |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage | <pre>set(object({<br>    iam_id = string<br>    mfa    = string<br>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var user\_mfa | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_allowed_ip_addresses"></a> [account\_allowed\_ip\_addresses](#output\_account\_allowed\_ip\_addresses) | Account Settings Allowed IP Addresses |
| <a name="output_account_allowed_ip_addresses_control_mode"></a> [account\_allowed\_ip\_addresses\_control\_mode](#output\_account\_allowed\_ip\_addresses\_control\_mode) | Account Settings Allowed IP Addresses Control Mode |
| <a name="output_account_allowed_ip_addresses_enforced"></a> [account\_allowed\_ip\_addresses\_enforced](#output\_account\_allowed\_ip\_addresses\_enforced) | Account Settings Allowed IP Addresses Enforced |
| <a name="output_account_iam_access_token_expiration"></a> [account\_iam\_access\_token\_expiration](#output\_account\_iam\_access\_token\_expiration) | Account Settings IAM Access Token Expiration |
| <a name="output_account_iam_active_session_timeout"></a> [account\_iam\_active\_session\_timeout](#output\_account\_iam\_active\_session\_timeout) | Account Settings IAM Active Session Timeout |
| <a name="output_account_iam_apikey_creation"></a> [account\_iam\_apikey\_creation](#output\_account\_iam\_apikey\_creation) | Account Settings IAM API Key Creation |
| <a name="output_account_iam_inactive_session_timeout"></a> [account\_iam\_inactive\_session\_timeout](#output\_account\_iam\_inactive\_session\_timeout) | Account Settings IAM Inactive Session Timeout |
| <a name="output_account_iam_mfa"></a> [account\_iam\_mfa](#output\_account\_iam\_mfa) | Account Settings IAM MFA |
| <a name="output_account_iam_refresh_token_expiration"></a> [account\_iam\_refresh\_token\_expiration](#output\_account\_iam\_refresh\_token\_expiration) | Account Settings IAM Refresh Token Expiration |
| <a name="output_account_iam_serviceid_creation"></a> [account\_iam\_serviceid\_creation](#output\_account\_iam\_serviceid\_creation) | Account Settings IAM Service ID Creation |
| <a name="output_account_iam_user_mfa_list"></a> [account\_iam\_user\_mfa\_list](#output\_account\_iam\_user\_mfa\_list) | Account Settings IAM User MFA List |
| <a name="output_account_public_access"></a> [account\_public\_access](#output\_account\_public\_access) | Account Settings Public Access |
| <a name="output_account_shell_settings_status"></a> [account\_shell\_settings\_status](#output\_account\_shell\_settings\_status) | Account Settings Shell Settings Status |
| <a name="output_activity_tracker_routes"></a> [activity\_tracker\_routes](#output\_activity\_tracker\_routes) | Activity Tracker Routes |
| <a name="output_activity_tracker_targets"></a> [activity\_tracker\_targets](#output\_activity\_tracker\_targets) | Activity Tracker Targets |
| <a name="output_cos_bucket"></a> [cos\_bucket](#output\_cos\_bucket) | COS Bucket |
| <a name="output_cos_instance_guid"></a> [cos\_instance\_guid](#output\_cos\_instance\_guid) | COS Instance GUID |
| <a name="output_cos_instance_id"></a> [cos\_instance\_id](#output\_cos\_instance\_id) | COS Instance ID |
| <a name="output_cos_s3_endpoint_private"></a> [cos\_s3\_endpoint\_private](#output\_cos\_s3\_endpoint\_private) | COS S3 Endpoint Private |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_trusted_profile_projects"></a> [trusted\_profile\_projects](#output\_trusted\_profile\_projects) | Trusted Profile Projects Profile |
| <a name="output_trusted_profile_projects_claim_rules"></a> [trusted\_profile\_projects\_claim\_rules](#output\_trusted\_profile\_projects\_claim\_rules) | Trusted Profile Projects Profile Claim Rules |
| <a name="output_trusted_profile_projects_links"></a> [trusted\_profile\_projects\_links](#output\_trusted\_profile\_projects\_links) | Trusted Profile Projects Profile Links |
| <a name="output_trusted_profile_projects_policies"></a> [trusted\_profile\_projects\_policies](#output\_trusted\_profile\_projects\_policies) | Trusted Profile Projects Profile Policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
