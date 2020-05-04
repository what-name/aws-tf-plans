## Get Latest Ubuntu 18.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

## Deploy instance
resource "aws_instance" "example_instance-1" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = var.instance_type
  subnet_id = "${aws_subnet.public-1.id}"

  security_groups = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_egress.id}",
    "${aws_security_group.allow_http.id}"
  ]

  tags = {
    Name = "example_instance"
    Project = "example"
  }

  key_name = "${aws_key_pair.example-ssh-key.key_name}"

  depends_on = [aws_security_group.allow_ssh, aws_security_group.allow_egress]

  user_data = "${file("userdata.sh")}"
}

## Allocate ElasticIP
resource "aws_eip" "example_instance-1_eip" {
  vpc = true
  instance = aws_instance.example_instance-1.id
  tags = {
    Name = "example_Instance_EIP"
    Project = "example"
  }
}

## Push SSH Public Key to instance
resource "aws_key_pair" "example-ssh-key" {
  key_name = "example-ssh-key"
  public_key = "${file("~/.ssh/example-ssh-key.pub")}"
}

## Outputs
output "DeployedAMI" {
  value = "${data.aws_ami.ubuntu.id}"
}

output "ElasticIP" {
  value = "${aws_eip.example_instance-1_eip.public_ip}"
}