output "vpc-id" {
    value = data.aws_vpc.test.id
}

output "subnet-id" {
    value = data.aws_subnet.selected.id
}