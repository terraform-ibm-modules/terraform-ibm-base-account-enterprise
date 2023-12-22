# IBM Cloud Account Infrastructure Base solution

An end-to-end deployable architecture solution that will provision the following:
- A resource group.
- A default set of FSCloud compliant Account Settings.
- A Cloud Object Storage instance.
- A Cloud Object Storage bucket encrypted with the KMS key.
- An Activity Tracker target for the COS bucket
- An Activity Tracker route to route events to the COS bucket.
- A new Trusted Profile for Projects access.

## Before You Begin
An IAM authorization policy must exist in the account where the KMS key resides which grants the Cloud Object Storage service in account to which this solution is being deployed, reader access to the KMS instance that the KMS key belongs to.
