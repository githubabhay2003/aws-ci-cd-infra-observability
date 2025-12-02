variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins and monitoring"
  type        = string
}

variable "my_ip" {
  description = "Your public IP address (without /32) used to restrict SSH and web access"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where Jenkins host will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet for Jenkins host"
  type        = string
}

variable "public_key" {
  description = "Public SSH key content to use for the EC2 key pair"
  type        = string
}
