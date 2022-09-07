data "aws_vpc" "test" {
    default = false
    filter {
    name   = "tag:Name"
    values = ["vpc-training"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-2"]
  }
}
