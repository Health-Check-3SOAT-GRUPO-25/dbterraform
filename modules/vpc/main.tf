# Configuração da VPC
resource "aws_vpc" "healthcheck_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "healthcheck-VPC"
  }
}

# Subnets Públicas
resource "aws_subnet" "healthcheck_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.healthcheck_vpc.id
  cidr_block              = cidrsubnet("10.0.128.0/20", 4, count.index)
  availability_zone       = element(data.aws_availability_zones.healthcheck_available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "healthcheck-Public-Subnet-${count.index}"
  }
}

# Subnets Privadas
resource "aws_subnet" "healthcheck_private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.healthcheck_vpc.id
  cidr_block              = cidrsubnet("10.0.160.0/20", 4, count.index)
  availability_zone       = element(data.aws_availability_zones.healthcheck_available.names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "healthcheck-Private-Subnet-${count.index}"
  }
}

# Grupo de Subnet para o RDS
resource "aws_db_subnet_group" "healthcheck_db_subnet_group" {
  name       = "healthcheck-db-subnet-group"
  subnet_ids = aws_subnet.healthcheck_private_subnet.*.id

  tags = {
    Name = "healthcheck-DB-Subnet-Group"
  }
}

# Internet Gateway para as subnets públicas
resource "aws_internet_gateway" "healthcheck_igw" {
  vpc_id = aws_vpc.healthcheck_vpc.id

  tags = {
    Name = "healthcheck-IGW"
  }
}

# Tabela de Roteamento para a VPC
resource "aws_route_table" "healthcheck_public_rt" {
  vpc_id = aws_vpc.healthcheck_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.healthcheck_igw.id
  }

  tags = {
    Name = "healthcheck-Public-RT"
  }
}

# Associação da Tabela de Roteamento com as Subnets Públicas
resource "aws_route_table_association" "healthcheck_public_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.healthcheck_public_subnet[count.index].id
  route_table_id = aws_route_table.healthcheck_public_rt.id
}
