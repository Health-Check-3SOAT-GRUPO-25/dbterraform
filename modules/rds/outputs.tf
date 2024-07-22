output "rds_instance_address" {
  value = aws_db_instance.healthcheck_sql_server.address
}