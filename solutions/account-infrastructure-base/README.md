# IBM Cloud Enterprise Account Base Layer

An end-to-end deployable architecture that will provision the following:
- A new resource group.
- A new Cloud Object Storage instance.
- A new Cloud Object Storage bucket.
- A new Activity Tracker instance.
- A new Trusted Profile for Projects access.
- A default set of Account Settings.

NOTE:
If the KMS instance you are using for encryption exists in a separate account from the account where the DA is being run you will need to create an Authorization Policy in the account that contains the KMS instance with the `source` of the policy being for COS services in the account where the DA is run and the `target` of the policy being the KMS service and providing `Reader` access to the KMS instance.
