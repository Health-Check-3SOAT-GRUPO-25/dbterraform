variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the RDS instance will be created."
}

# variable "db_subnet_ids" {
#   description = "List of subnet IDs for the RDS instance."
# }

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group"
}

variable "dbUserName" {
  type = string
}

variable "dbPassword" {
    type = string
}