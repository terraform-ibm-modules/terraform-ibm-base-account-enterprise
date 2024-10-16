# IBM Cloud Account infrastructure base module

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-base-account-enterprise?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-base-account-enterprise/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
This module is a general base layer module for setting up a newly provisioned account with a default provision of:

- Base Resource Group
- IAM Account Settings
- Trusted Profile + Access Group for Projects

This module also optionally supports provisioning the following resources:

- Activity Tracker routing + COS instance and bucket

![account-infrastructure-base](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/main/reference-architectures/base-account-enterprise.svg)


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-account-infrastructure-base](#terraform-ibm-account-infrastructure-base)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


## Reference architectures
- [IBM Cloud Account Infrastructure Base solution](./solutions/account-infrastructure-base/)

<!-- This heading should always match the name of the root level module (aka the repo name) -->
## terraform-ibm-account-infrastructure-base

### Current limitations:
The module currently does not support setting the following FSCloud requirements:
- Check whether user list visibility restrictions are configured in IAM settings for the account owner
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting) as a workaround to set this manually in the UI
- Check whether the Financial Services Validated setting is enabled in account settings
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated) as a workaround to set this manually in the UI

Tracking issue with IBM provider -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

#### Before You Begin
If you are using this module to create an ATracker route and IBM Cloud Object Storage instance and bucket, and using a key from a key management service in a separate account, you will need an IAM authorization policy in the account where the key management service resides which grants the IBM Cloud Object Storage service in this account Reader access to the key management service.

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
    source  = "terraform-ibm-modules/account-infrastructure-base/ibm"
    version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
    providers = { # providers block necessary for logdna provider aliases
        logdna.at = logdna.at
        logdna.ld = logdna.ld
    }
    region                            = "us-south"
    resource_group_name               = "account-base-resource-group"
    provision_atracker_cos            = true # setting this enables provisioning of the ATracker + COS resources
    cos_skip_iam_authorization_policy = false # setting this enables provisioning an authorization policy between the COS instances and the KMS instance given via the CRN
    kms_key_crn                       = "crn:v1:bluemix:public:(kms|hs-crypto):(region):a/(Account ID):(KMS instance GUID)::"
    cos_instance_name                 = "account-base-cos-instance"
    cos_bucket_name                   = "atracker-cos-bucket"
    cos_target_name                   = "atracker-cos-target"
    trusted_profile_name              = "account-base-trusted-profile"
    activity_tracker_route_name       = "atracker-cos-route"
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.62.0, < 2.0.0 |
| <a name="requirement_logdna"></a> [logdna](#requirement\_logdna) | >= 1.14.2, < 2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_settings"></a> [account\_settings](#module\_account\_settings) | terraform-ibm-modules/iam-account-settings/ibm | 2.10.7 |
| <a name="module_activity_tracker"></a> [activity\_tracker](#module\_activity\_tracker) | terraform-ibm-modules/observability-instances/ibm//modules/activity_tracker | 2.19.1 |
| <a name="module_cos"></a> [cos](#module\_cos) | terraform-ibm-modules/cos/ibm//modules/fscloud | 8.11.16 |
| <a name="module_existing_resource_group"></a> [existing\_resource\_group](#module\_existing\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.6 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.6 |
| <a name="module_trusted_profile_projects"></a> [trusted\_profile\_projects](#module\_trusted\_profile\_projects) | terraform-ibm-modules/trusted-profile/ibm | 1.0.4 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds, has no effect when `skip_iam_account_settings` is true. | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long (seconds) a user is allowed to work continuously in the account, has no effect when `skip_iam_account_settings` is true. | `number` | `86400` | no |
| <a name="input_activity_tracker_locations"></a> [activity\_tracker\_locations](#input\_activity\_tracker\_locations) | Location of the route for the Activity Tracker, logs from these locations will be sent to the specified target. Supports passing individual regions, as well as `global` and `*`. | `list(string)` | <pre>[<br/>  "*",<br/>  "global"<br/>]</pre> | no |
| <a name="input_activity_tracker_route_name"></a> [activity\_tracker\_route\_name](#input\_activity\_tracker\_route\_name) | Name of the route for the Activity Tracker, required if 'var.provision\_atracker\_cos' is true. | `string` | `null` | no |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets from which IAM tokens can be created for the account, has no effect when `skip_iam_account_settings` is true. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value), has no effect when `skip_iam_account_settings` is true. | `string` | `"RESTRICTED"` | no |
| <a name="input_audit_resource_group_name"></a> [audit\_resource\_group\_name](#input\_audit\_resource\_group\_name) | The name of the audit resource group to create. | `string` | `null` | no |
| <a name="input_cos_bucket_access_tags"></a> [cos\_bucket\_access\_tags](#input\_cos\_bucket\_access\_tags) | A list of Access Tags applied to the created bucket. | `list(string)` | `[]` | no |
| <a name="input_cos_bucket_archive_days"></a> [cos\_bucket\_archive\_days](#input\_cos\_bucket\_archive\_days) | Number of days to archive objects in the bucket. | `number` | `20` | no |
| <a name="input_cos_bucket_archive_enabled"></a> [cos\_bucket\_archive\_enabled](#input\_cos\_bucket\_archive\_enabled) | Set as true to enable archiving on the COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_archive_type"></a> [cos\_bucket\_archive\_type](#input\_cos\_bucket\_archive\_type) | Type of archiving to use on bucket. | `string` | `"Glacier"` | no |
| <a name="input_cos_bucket_cbr_rules"></a> [cos\_bucket\_cbr\_rules](#input\_cos\_bucket\_cbr\_rules) | COS Bucket CBR Rules | <pre>list(object({<br/>    description = string<br/>    account_id  = string<br/>    rule_contexts = list(object({<br/>      attributes = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>    }))<br/>    enforcement_mode = string<br/>    tags = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), [])<br/>    operations = optional(list(object({<br/>      api_types = list(object({<br/>        api_type_id = string<br/>      }))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_cos_bucket_expire_days"></a> [cos\_bucket\_expire\_days](#input\_cos\_bucket\_expire\_days) | Number of days before expiry. | `number` | `365` | no |
| <a name="input_cos_bucket_expire_enabled"></a> [cos\_bucket\_expire\_enabled](#input\_cos\_bucket\_expire\_enabled) | A flag to control expiry rule on the bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_management_endpoint_type"></a> [cos\_bucket\_management\_endpoint\_type](#input\_cos\_bucket\_management\_endpoint\_type) | The type of endpoint for the IBM terraform provider to use to manage the bucket. (public, private or direct) | `string` | `"public"` | no |
| <a name="input_cos_bucket_name"></a> [cos\_bucket\_name](#input\_cos\_bucket\_name) | The name to give the newly provisioned COS bucket which will be used for Activity Tracker logs, required if 'var.provision\_atracker\_cos' is true. | `string` | `null` | no |
| <a name="input_cos_bucket_object_versioning_enabled"></a> [cos\_bucket\_object\_versioning\_enabled](#input\_cos\_bucket\_object\_versioning\_enabled) | A flag to control object versioning on the bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_retention_default"></a> [cos\_bucket\_retention\_default](#input\_cos\_bucket\_retention\_default) | Specifies default duration of time an object that can be kept unmodified for COS bucket. | `number` | `90` | no |
| <a name="input_cos_bucket_retention_enabled"></a> [cos\_bucket\_retention\_enabled](#input\_cos\_bucket\_retention\_enabled) | Retention enabled for COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_retention_maximum"></a> [cos\_bucket\_retention\_maximum](#input\_cos\_bucket\_retention\_maximum) | Specifies maximum duration of time an object that can be kept unmodified for COS bucket. | `number` | `350` | no |
| <a name="input_cos_bucket_retention_minimum"></a> [cos\_bucket\_retention\_minimum](#input\_cos\_bucket\_retention\_minimum) | Specifies minimum duration of time an object must be kept unmodified for COS bucket. | `number` | `90` | no |
| <a name="input_cos_bucket_retention_permanent"></a> [cos\_bucket\_retention\_permanent](#input\_cos\_bucket\_retention\_permanent) | Specifies a permanent retention status either enable or disable for COS bucket. | `bool` | `false` | no |
| <a name="input_cos_bucket_storage_class"></a> [cos\_bucket\_storage\_class](#input\_cos\_bucket\_storage\_class) | COS Bucket storage class type | `string` | `null` | no |
| <a name="input_cos_instance_access_tags"></a> [cos\_instance\_access\_tags](#input\_cos\_instance\_access\_tags) | A list of Access Tags applied to the created COS instance. | `list(string)` | `[]` | no |
| <a name="input_cos_instance_cbr_rules"></a> [cos\_instance\_cbr\_rules](#input\_cos\_instance\_cbr\_rules) | CBR Rules for the COS instance. | <pre>list(object({<br/>    description = string<br/>    account_id  = string<br/>    rule_contexts = list(object({<br/>      attributes = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })))<br/>    }))<br/>    enforcement_mode = string<br/>    tags = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), [])<br/>    operations = optional(list(object({<br/>      api_types = list(object({<br/>        api_type_id = string<br/>      }))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_cos_instance_name"></a> [cos\_instance\_name](#input\_cos\_instance\_name) | The name to give the cloud object storage instance that will be provisioned by this module, required if 'var.provision\_atracker\_cos' is true. | `string` | `null` | no |
| <a name="input_cos_plan"></a> [cos\_plan](#input\_cos\_plan) | Plan of the COS instance created by the module | `string` | `"standard"` | no |
| <a name="input_cos_target_name"></a> [cos\_target\_name](#input\_cos\_target\_name) | Name of the COS Target for Activity Tracker, required if 'var.provision\_atracker\_cos' is true. | `string` | `null` | no |
| <a name="input_devops_resource_group_name"></a> [devops\_resource\_group\_name](#input\_devops\_resource\_group\_name) | The name of the devops resource group to create. | `string` | `null` | no |
| <a name="input_edge_resource_group_name"></a> [edge\_resource\_group\_name](#input\_edge\_resource\_group\_name) | The name of the edge resource group to create. | `string` | `null` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | Whether the IP address restriction is enforced. Set the value to `false` to test the impact of the restriction on your account, once the impact of the restriction has been observed set the value to `true`. | `bool` | `true` | no |
| <a name="input_existing_audit_resource_group_name"></a> [existing\_audit\_resource\_group\_name](#input\_existing\_audit\_resource\_group\_name) | The name of the existing resource group to use for audit resources, takes precedence over `audit_resource_group_name`. | `string` | `null` | no |
| <a name="input_existing_devops_resource_group_name"></a> [existing\_devops\_resource\_group\_name](#input\_existing\_devops\_resource\_group\_name) | The name of the existing resource group to use for devops resources, takes precedence over `devops_resource_group_name`. | `string` | `null` | no |
| <a name="input_existing_edge_resource_group_name"></a> [existing\_edge\_resource\_group\_name](#input\_existing\_edge\_resource\_group\_name) | The name of the existing resource group to use for edge resources, takes precedence over `edge_resource_group_name`. | `string` | `null` | no |
| <a name="input_existing_management_resource_group_name"></a> [existing\_management\_resource\_group\_name](#input\_existing\_management\_resource\_group\_name) | The name of the existing resource group to use for management resources, takes precedence over `management_resource_group_name`. | `string` | `null` | no |
| <a name="input_existing_observability_resource_group_name"></a> [existing\_observability\_resource\_group\_name](#input\_existing\_observability\_resource\_group\_name) | The name of the existing resource group to use for observability resources, takes precedence over `observability_resource_group_name`. Required if `var.provision_atracker_cos` is true and `var.observability_resource_group_name` is not provided. | `string` | `null` | no |
| <a name="input_existing_security_resource_group_name"></a> [existing\_security\_resource\_group\_name](#input\_existing\_security\_resource\_group\_name) | The name of the existing resource group to use for security resources, takes precedence over `security_resource_group_name`. | `string` | `null` | no |
| <a name="input_existing_workload_resource_group_name"></a> [existing\_workload\_resource\_group\_name](#input\_existing\_workload\_resource\_group\_name) | The name of the existing resource group to use for workload resources, takes precedence over `workload_resource_group_name`. | `string` | `null` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle, has no effect when `skip_iam_account_settings` is true. | `string` | `"7200"` | no |
| <a name="input_kms_key_crn"></a> [kms\_key\_crn](#input\_kms\_key\_crn) | CRN of the KMS key to use to encrypt the data in the COS bucket, required if 'var.provision\_atracker\_cos' is true. | `string` | `null` | no |
| <a name="input_management_resource_group_name"></a> [management\_resource\_group\_name](#input\_management\_resource\_group\_name) | The name of the management resource group to create. | `string` | `null` | no |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT\_SET' to unset account setting and use service default, has no effect when `skip_iam_account_settings` is true. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users), has no effect when `skip_iam_account_settings` is true. | `string` | `"TOTP4ALL"` | no |
| <a name="input_observability_resource_group_name"></a> [observability\_resource\_group\_name](#input\_observability\_resource\_group\_name) | The name of the observability resource group to create. Required if `var.provision_atracker_cos` is true and `var.existing_observability_resource_group_name` is not provided. | `string` | `null` | no |
| <a name="input_provision_atracker_cos"></a> [provision\_atracker\_cos](#input\_provision\_atracker\_cos) | Enable to create an Atracker route and COS instance + bucket. | `bool` | `false` | no |
| <a name="input_provision_trusted_profile_projects"></a> [provision\_trusted\_profile\_projects](#input\_provision\_trusted\_profile\_projects) | Controls whether the Trusted Profile for Projects is provisioned. | `bool` | `true` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not, has no effect when `skip_iam_account_settings` is true. | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds, has no effect when `skip_iam_account_settings` is true. | `string` | `"259200"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to provision the COS resources created by this solution. | `string` | `"us-south"` | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | A list of tags applied to the COS resources created by the module. | `list(string)` | `[]` | no |
| <a name="input_security_resource_group_name"></a> [security\_resource\_group\_name](#input\_security\_resource\_group\_name) | The name of the security resource group to create. | `string` | `null` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs, has no effect when `skip_iam_account_settings` is true. Allowed values are 'RESTRICTED', 'NOT\_RESTRICTED', or 'NOT\_SET' (to 'unset' a previous set value). | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Enable global shell settings to all users in the account, has no effect when `skip_iam_account_settings` is true. | `bool` | `false` | no |
| <a name="input_skip_atracker_cos_iam_auth_policy"></a> [skip\_atracker\_cos\_iam\_auth\_policy](#input\_skip\_atracker\_cos\_iam\_auth\_policy) | Set to true to skip the creation of an IAM authorization policy that permits the Activity Tracker service Object Writer access to the Cloud Object Storage instance provisioned by this module. NOTE: If skipping, you must ensure the auth policy exists on the account before running the module. | `bool` | `false` | no |
| <a name="input_skip_cloud_shell_calls"></a> [skip\_cloud\_shell\_calls](#input\_skip\_cloud\_shell\_calls) | Skip Cloud Shell calls in the account, has no effect when `skip_iam_account_settings` is true. | `bool` | `false` | no |
| <a name="input_skip_cos_kms_auth_policy"></a> [skip\_cos\_kms\_auth\_policy](#input\_skip\_cos\_kms\_auth\_policy) | Whether to enable creating an IAM authoriation policy between the IBM Cloud Object Storage instance and the Key Management service instance of the CRN provided in `kms_key_crn`. This variable has no effect if `provision_atracker_cos` is false. | `bool` | `false` | no |
| <a name="input_skip_iam_account_settings"></a> [skip\_iam\_account\_settings](#input\_skip\_iam\_account\_settings) | Set to true to skip the IAM account settings being applied to the account | `bool` | `false` | no |
| <a name="input_trusted_profile_description"></a> [trusted\_profile\_description](#input\_trusted\_profile\_description) | Description of the trusted profile. | `string` | `"Trusted Profile for Projects access"` | no |
| <a name="input_trusted_profile_name"></a> [trusted\_profile\_name](#input\_trusted\_profile\_name) | Name of the trusted profile, required if `provision_trusted_profile_projects` is true. | `string` | `null` | no |
| <a name="input_trusted_profile_roles"></a> [trusted\_profile\_roles](#input\_trusted\_profile\_roles) | List of roles given to the trusted profile. | `list(string)` | <pre>[<br/>  "Administrator"<br/>]</pre> | no |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage, has no effect when `skip_iam_account_settings` is true. | <pre>set(object({<br/>    iam_id = string<br/>    mfa    = string<br/>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var user\_mfa, has no effect when `skip_iam_account_settings` is true. | `bool` | `false` | no |
| <a name="input_workload_resource_group_name"></a> [workload\_resource\_group\_name](#input\_workload\_resource\_group\_name) | The name of the workload resource group to create. | `string` | `null` | no |

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
| <a name="output_audit_resource_group_id"></a> [audit\_resource\_group\_id](#output\_audit\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_audit_resource_group_name"></a> [audit\_resource\_group\_name](#output\_audit\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_cos_bucket"></a> [cos\_bucket](#output\_cos\_bucket) | COS Bucket |
| <a name="output_cos_instance_guid"></a> [cos\_instance\_guid](#output\_cos\_instance\_guid) | COS Instance GUID |
| <a name="output_cos_instance_id"></a> [cos\_instance\_id](#output\_cos\_instance\_id) | COS Instance ID |
| <a name="output_devops_resource_group_id"></a> [devops\_resource\_group\_id](#output\_devops\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_devops_resource_group_name"></a> [devops\_resource\_group\_name](#output\_devops\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_edge_resource_group_id"></a> [edge\_resource\_group\_id](#output\_edge\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_edge_resource_group_name"></a> [edge\_resource\_group\_name](#output\_edge\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_management_resource_group_id"></a> [management\_resource\_group\_id](#output\_management\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_management_resource_group_name"></a> [management\_resource\_group\_name](#output\_management\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_observability_resource_group_id"></a> [observability\_resource\_group\_id](#output\_observability\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_observability_resource_group_name"></a> [observability\_resource\_group\_name](#output\_observability\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_security_resource_group_id"></a> [security\_resource\_group\_id](#output\_security\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_security_resource_group_name"></a> [security\_resource\_group\_name](#output\_security\_resource\_group\_name) | Name of the Resource Group created by the module. |
| <a name="output_trusted_profile_projects"></a> [trusted\_profile\_projects](#output\_trusted\_profile\_projects) | Trusted Profile Projects Profile |
| <a name="output_trusted_profile_projects_claim_rules"></a> [trusted\_profile\_projects\_claim\_rules](#output\_trusted\_profile\_projects\_claim\_rules) | Trusted Profile Projects Profile Claim Rules |
| <a name="output_trusted_profile_projects_links"></a> [trusted\_profile\_projects\_links](#output\_trusted\_profile\_projects\_links) | Trusted Profile Projects Profile Links |
| <a name="output_trusted_profile_projects_policies"></a> [trusted\_profile\_projects\_policies](#output\_trusted\_profile\_projects\_policies) | Trusted Profile Projects Profile Policies |
| <a name="output_workload_resource_group_id"></a> [workload\_resource\_group\_id](#output\_workload\_resource\_group\_id) | ID of the Resource Group created by the module. |
| <a name="output_workload_resource_group_name"></a> [workload\_resource\_group\_name](#output\_workload\_resource\_group\_name) | Name of the Resource Group created by the module. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
