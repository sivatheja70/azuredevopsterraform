#backend
terraform {
  backend "s3" {
    bucket = "terraform-statefile-123456"
    key    = "master.tfstate" 
    region = "us-east-1"
  }
}
