#######################################
# Network module
#######################################

module "network" {
  source = "./modules/network"

  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

#######################################
# Jenkins host module
#######################################

module "jenkins_host" {
  source = "./modules/jenkins_host"

  environment      = var.environment
  instance_type    = var.instance_type
  my_ip            = var.my_ip
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id

  public_key = file("${path.root}/keys/jenkins-aws.pub")
}

