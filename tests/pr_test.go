// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"log"
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const solutionDir = "solutions/account-infrastructure-base"

// Define a struct with fields that match the structure of the YAML data
const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

var permanentResources map[string]interface{}

func TestMain(m *testing.M) {

	var err error
	permanentResources, err = common.LoadMapFromYaml(yamlLocation)
	if err != nil {
		log.Fatal(err)
	}

	os.Exit(m.Run())
}

func setupOptions(t *testing.T, prefix string, dir string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: dir,
		Prefix:       prefix,
	})
	options.TerraformVars = map[string]interface{}{
		"prefix":                 options.Prefix,
		"kms_key_crn":            permanentResources["hpcs_south_root_key_crn"],
		"provision_atracker_cos": true,
		"provision_cbr":          false, // disabling CBR rules until it is figured out how to run the tests in enterprise sub accounts
		"allowed_ip_addresses": []string{
			"0.0.0.0/0",
		},
		"observability_resource_group_name": "obs-resource-group",
	}

	return options
}

func TestRunDA(t *testing.T) {
	/* Unable to run tests in parallel as both are trying to update account settings at
	   the same time, and the following error is observed:
	   "Error: UpdateAccountSettingsWithContext failed Couldn't save cloudshell settings for account"
	*/

	// t.Parallel()

	options := setupOptions(t, "base-acct", solutionDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeDA(t *testing.T) {
	/* Unable to run tests in parallel as both are trying to update account settings at
	   the same time, and the following error is observed:
	   "Error: UpdateAccountSettingsWithContext failed Couldn't save cloudshell settings for account"
	*/

	// t.Parallel()

	options := setupOptions(t, "base-acct-upg", solutionDir)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
