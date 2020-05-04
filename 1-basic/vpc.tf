## Create VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "example_VPC"
    Project = "example"
  }
}

## Create Public subnet 1
resource "aws_subnet" "public-1" {
  vpc_id = "${aws_vpc.example_vpc.id}"
  cidr_block = "10.10.0.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public-1"
    Project = "example"
  }
}

## Create Internet Gateway for the new VPC
resource "aws_internet_gateway" "example_vpc_igw" {
  vpc_id = "${aws_vpc.example_vpc.id}"
  tags = {
    Name = "example-vpc-igw"
    Project = "example"
  }
}

## Create route table for public subnets
resource "aws_route_table" "rt1" {
  vpc_id = "${aws_vpc.example_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.example_vpc_igw.id}"
  }
  tags = {
    Name = "rt1"
    Project = "example"
  }
}

## Associate route table 1 with public subnet
resource "aws_route_table_association" "rt-association" {
  subnet_id = "${aws_subnet.public-1.id}"
  route_table_id = "${aws_route_table.rt1.id}"
}