resource "aws_db_instance" "healthcheck_sql_server" {
  instance_class       = var.instance_class
  allocated_storage    = 20
  max_allocated_storage = 30
  engine               = "sqlserver-ex"
  engine_version       = "15.00"
  identifier           = "healthcheck-sqlserver-instance"
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.healthcheck_sg_rds.id]
  parameter_group_name = "default.sqlserver-ex-15.0"
  username             = var.dbUserName
  password             = var.dbPassword
  multi_az            = false 
  skip_final_snapshot = true
  apply_immediately            = true
  deletion_protection          = false
  performance_insights_enabled = true
  backup_retention_period      = 1
  backup_window                = "00:00-00:30"
  copy_tags_to_snapshot        = true
  delete_automated_backups     = true
  tags = {
    Name = "healthcheck-SqlServerInstance"
  }
}

resource "aws_security_group" "healthcheck_sg_rds" {
  name        = "healthcheck-sql-server-rds-sg"
  description = "Security group for healthcheck SQL Server RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "healthcheck-sql-server-rds-sg"
  }
}



