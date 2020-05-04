variable "region" {
  description = "The default region for deployments."
  default = "us-east-1"
}

variable "instance_type" {
  description = "What instance type gets deployed"
  default = "t2.micro"
}

# you can also use a file "terraform.tfvars"
# with the content - region="us-east-1"
# 
# or you can use the comman line and export variables
# export TF_VAR_region="us-east-1"
# 
# none of these work somehow tho?
# these are from the official guide
#
