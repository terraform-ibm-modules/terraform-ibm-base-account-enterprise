# IBM Cloud Account Infrastructure Base solution

An end-to-end deployable architecture solution that will provision the following:
- A resource group.
- A default set of FSCloud compliant Account Settings.
- A Cloud Object Storage instance.
- A Cloud Object Storage bucket encrypted with the KMS key.
- An Activity Tracker target for the COS bucket
- An Activity Tracker route to route events to the COS bucket.
- A new Trusted Profile for Projects access.
- A set of context-based restriction rules and zones that are compliant with IBM Cloud Framework for Financial Services.

![account-infrastructure-base](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/main/reference-architectures/base-account-enterprise.svg)

## Before You Begin
An IAM authorization policy must exist in the account where the KMS key resides which grants the Cloud Object Storage service in account to which this solution is being deployed, reader access to the KMS instance that the KMS key belongs to.

## Current limitations:
The module currently does not support setting the following FSCloud requirements:
- Check whether user list visibility restrictions are configured in IAM settings for the account owner
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting) as a workaround to set this manually in the UI
- Check whether the Financial Services Validated setting is enabled in account settings
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated) as a workaround to set this manually in the UI

Tracking issue with IBM provider -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204
