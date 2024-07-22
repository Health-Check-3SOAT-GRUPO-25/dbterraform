
resource "aws_vpc" "healthcheck_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "healthcheck-VPC"
  }
}

resource "aws_subnet" "healthcheck_db_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.healthcheck_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 2, count.index)
  availability_zone       = element(data.aws_availability_zones.healthcheck_available.names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "healthcheck-DB-Subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "healthcheck_db_subnet_group" {
  name       = "healthcheck-db-subnet-group"
  subnet_ids = aws_subnet.healthcheck_db_subnet.*.id

  tags = {
    Name = "healthcheck-DB-Subnet-Group"
  }
}

