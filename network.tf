# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.id_tag}-vpc"
    Project = var.project_tag
    ID      = var.id_tag
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" # Replace with your desired AZ

  tags = {
    Name    = "${var.id_tag}-subnet"
    Project = var.project_tag
    ID      = var.id_tag
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.id_tag}-igw"
    Project = var.project_tag
    ID      = var.id_tag
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name    = "${var.id_tag}-route-table"
    Project = var.project_tag
    ID      = var.id_tag
  }
}

# Associate the Subnet with the Route Table
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create a Security Group
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name   = "${var.id_tag}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (use cautiously)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.id_tag}-sg"
    Project = var.project_tag
    ID      = var.id_tag
  }
}