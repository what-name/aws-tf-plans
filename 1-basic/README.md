# Terraform AWS Basic
This is a very basic TF plan to bootstrap the following setup on AWS:
- A new VPC
- A Public Subnet inside that VPC
- An Internet Gateway
- A Routing table for the the Public Subnet, with 0.0.0.0/0 pointing to the IGW
- 3 Security Groups: SSH ingress, HTTP ingress, ALL egress - associated with public subnet
- 1 Ubuntu EC2 instance with the latest Ubuntu 16 AMI, Nginx installed and running
- 1 ElasticIP associated with the EC2 instance

All of this is included in the free tier.

# Get started
1. Clone this repo
`git clone https://github.com/what-name/aws-tf-plans.git && cd aws-tf-plans/1-basic`

2. Create an Access Key for your admin user in the AWS console and change the contents of the `provider.tf` file accordingly.

3. Create your ssh key to be deployed onto the EC2 instance.
	1. `ssh-keygen` -> save to `~/.ssh/example-ssh-key`
	2. Edit the `ec2.tf` file so that the SSH key's path points to your public key.
(You can use an already available SSH key in your AWS account, edit the `ec2.tf` file accordingly.)

4. `terraform init` - to download the required plugins for terraform

5. `terraform plan` - to see what it would do

6. `terraform apply` - to run the plan

7. The ElasticIP of the instance will be printed to the console. Copy & paste into your browser to make sure it worked and you're presented with the Nginx default webpage.

8. `terraform destroy` - to destroy everything that got deployed by the plan