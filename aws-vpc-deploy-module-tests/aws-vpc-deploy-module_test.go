package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestMyTerraformModule(t *testing.T) {
	awsAccessKey := os.Getenv("AWS_ACCESS_KEY_ID")
	awsSecretKey := os.Getenv("AWS_SECRET_ACCESS_KEY")

	// Ensure the variables are not empty
	if awsAccessKey == "" || awsSecretKey == "" {
		t.Fatal("AWS environment variables must be set")
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "./fixtures/sandbox-deploy/",
		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_ACCESS_KEY_ID":     awsAccessKey,
			"AWS_SECRET_ACCESS_KEY": awsSecretKey,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Add assertions here to validate the correctness of the Terraform code.
}
