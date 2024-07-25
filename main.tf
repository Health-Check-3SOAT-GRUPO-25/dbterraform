module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
}

module "rds" {
  source = "./modules/rds"
  instance_class = "db.t3.micro"
  db_subnet_group_name = module.vpc.db_subnet_group_name
  dbPassword =  var.dbPassword
  dbUserName = var.dbUserName
  vpc_id         = module.vpc.vpc_id
  # db_subnet_ids  = module.vpc.db_subnet_ids
}
