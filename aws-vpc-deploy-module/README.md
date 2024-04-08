# vpc-aws-terraform module

## Synopsis

AWS VPC Terraform Deployment module designed to deploy AWS VPC.

Module meets [Terraform Module Composition Best practices](https://developer.hashicorp.com/terraform/language/modules/develop/composition)

Module allows to do the following:

- Deploy 1 AWS VPC
- Deploy 1 Internet Gateway
- Between 1-3 public networks (each network goes to sepate AZ)
- Between 1-3 private networks (each network goes to sepate AZ)
- 1-3 private route tables
- 1 public ACL for public newtorks
- 1 private ACL for private networks

## Usage

To deploy VPC using this module:

- Reference module using either local or remote source in your deployment Terraform file
- Specify required parameters within your deployment Terraform file
- Perform terraform init and deployment

## Basic usage example

```hcl
module "aws-vpc-deploy-module" {
  source = "../aws-vpc-deploy-module"

  vpc_name = "sandbox"

  region = "eu-central-1"

  vpc_cidr_block = "10.0.0.0/20"
  
  # Specify the CIDR blocks for your subnets
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  
  # Specify the number of subnets to create (1-3)
  subnet_count = 3
}
```

## Best practices followed by this module code

- VPC and resources within it grouped into the same module, further per resource type modularization is possible but depends on real use case scenario
- Dynamic naming convention - we prepend all resource names consistently starting with VPC name prefix, followed by resource type and numeric identifier (if applicable) for the cases when we have multiple instances of the same resource type
- Comprehensible variable descriptions - we include variable descriptions into variable definitions and illustrate usage in module documentation (alternatively we could opt for adding usage examples into multiline description of each variable using here-document/heredoc style)
- Inputs and validation - region ans subnet_count variables use validation to ensure clear error messages and fail fast approach
- Outputs expsosure - we have defined ouptupts to displays essential information about deployed resources
- Dynamic blocks