package test

import (
	"os"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
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

	// Validate VPC
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	validateVPC(t, vpcId, "10.0.0.0/20", "eu-central-1")

	// Validate Subnets
	publicSubnetIds := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
	privateSubnetIds := terraform.OutputList(t, terraformOptions, "private_subnet_ids")
	expectedPublicCidrs := []string{"10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"}
	expectedPrivateCidrs := []string{"10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"}
	validateSubnets(t, publicSubnetIds, expectedPublicCidrs, "eu-central-1")
	validateSubnets(t, privateSubnetIds, expectedPrivateCidrs, "eu-central-1")
}

func validateVPC(t *testing.T, vpcId, expectedCidr, region string) {
	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(region),
	}))

	svc := ec2.New(sess)
	resp, err := svc.DescribeVpcs(&ec2.DescribeVpcsInput{
		VpcIds: []*string{aws.String(vpcId)},
	})
	if err != nil {
		t.Fatal(err)
	}
	if *resp.Vpcs[0].CidrBlock != expectedCidr {
		t.Fatalf("VPC CIDR block %s does not match expected %s", *resp.Vpcs[0].CidrBlock, expectedCidr)
	}
}

func validateSubnets(t *testing.T, subnetIds []string, expectedCidrs []string, region string) {
	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(region),
	}))

	svc := ec2.New(sess)
	resp, err := svc.DescribeSubnets(&ec2.DescribeSubnetsInput{
		SubnetIds: aws.StringSlice(subnetIds),
	})
	if err != nil {
		t.Fatal(err)
	}

	for _, subnet := range resp.Subnets {
		found := false
		for _, expectedCidr := range expectedCidrs {
			if *subnet.CidrBlock == expectedCidr {
				found = true
				break
			}
		}
		if !found {
			t.Fatalf("Subnet CIDR block %s is not in the expected list", *subnet.CidrBlock)
		}
	}
}
