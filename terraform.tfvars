aws_region = "us-east-1"

project_prefix = "cmtr-fvj3554p-01"

vpc_cidr = "10.10.0.0/16"

subnets = [
  {
    name              = "subnet-public-a"
    cidr_block        = "10.10.1.0/24"
    availability_zone = "us-east-1a"
  },
  {
    name              = "subnet-public-b"
    cidr_block        = "10.10.3.0/24"
    availability_zone = "us-east-1b"
  },
  {
    name              = "subnet-public-c"
    cidr_block        = "10.10.5.0/24"
    availability_zone = "us-east-1c"
  }
]

internet_gateway_suffix = "igw"
<<<<<<< HEAD
routing_table_suffix    = "rt"
=======
routing_table_suffix    = "rt"
>>>>>>> f459b53 (push)
