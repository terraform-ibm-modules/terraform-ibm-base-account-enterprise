# IBM Cloud Account Infrastructure Base solution

An end-to-end deployable architecture solution that provisions the following infrastructure:
- A resource group
- A default set of account settings that are compliant with the IBM Cloud for Financial Services framework 
- An IBM Cloud Object Storage instance
- An IBM Cloud Object Storage bucket encrypted with the key management service key
- An Activity Tracker target for the Object Storage bucket
- An Activity Tracker route that routes events to the Object Storage bucket
- A trusted profile to give access for IBM Cloud Projects to deploy solutions securely in this account

![account-infrastructure-base](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/main/reference-architectures/base-account-enterprise.svg)

## Before you begin
Create an IAM authorization policy in the account where the Key Management Service (KMS) key resides. Grant the Object Storage service in the account where this solution is deployed the Reader role on the KMS instance that the key belongs to.


## Limitations
The solution currently does not support configuring the following settings that are required for FSCloud compliance:
- The user list visibility IAM setting. An account owener can enable this restriction manually in the IBM Cloud console by following these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting).
- The Financial Services Validated setting. An account owner can enable the account to be Financial Services Validated designated, which means your account stores and manages regulated financial services information. Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated) to set this manually in the IBM Cloud console.

Tracking issue with IBM provider -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204
