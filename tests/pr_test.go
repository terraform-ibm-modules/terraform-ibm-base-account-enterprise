// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"log"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const completeExampleDir = "solutions/account-infrastructure-base"

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
		TerraformVars: map[string]interface{}{
			"kms_key_crn": permanentResources["hpcs_south_root_key_crn"],
		},
	})
	options.TerraformVars = map[string]interface{}{
		"prefix": options.Prefix,
	}

	return options
}

func TestRunDA(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "base-acct", completeExampleDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeDA(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "base-acct-upg", completeExampleDir)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
