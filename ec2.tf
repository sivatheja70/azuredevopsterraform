provider "aws" {
  region = "us-east-1"
}

locals {

  user_data = <<-EOT
  #!/bin/bash
  systemctl enable amazon-ssm-agent
  systemctl start amazon-ssm-agent
  EOT

  tags = {
    Owner       = "siva"
    Environment = "sandbox"
  }
}




module "ec2_test" {
  source = "./modules/ec2"

  name = "test-instance"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  subnet_id                   = data.aws_subnet.selected.id
  vpc_security_group_ids      = [aws_security_group.test.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.test_profile.name

  user_data_base64            = base64encode(local.user_data)
  
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 8
      
    },
  ]
  tags = local.tags
}
