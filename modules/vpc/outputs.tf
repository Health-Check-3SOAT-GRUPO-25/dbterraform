output "db_subnet_group_name" {
  value = aws_db_subnet_group.healthcheck_db_subnet_group.name
  description = "The name of the DB subnet group in the VPC module"
}

output "vpc_id" {
  value = aws_vpc.healthcheck_vpc.id
}

# output "db_subnet_ids" {
#   value = aws_subnet.healthcheck_db_subnet.*.id
# }