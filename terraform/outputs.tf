output "jenkins_public_ip" {
  description = "Public IP of the Jenkins EC2 instance"
  value       = module.jenkins_host.public_ip
}

output "jenkins_private_ip" {
  description = "Private IP of the Jenkins EC2 instance"
  value       = module.jenkins_host.private_ip
}

output "vpc_id" {
  description = "ID of the main VPC"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.network.public_subnet_id
}

