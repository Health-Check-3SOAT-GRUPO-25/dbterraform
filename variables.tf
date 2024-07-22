variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

variable "dbUserName" {
  description = "Inform database username"
}

variable "dbPassword" {
  description = "Inform database password"
}