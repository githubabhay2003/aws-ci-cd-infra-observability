#######################################
# Data source: Ubuntu 22.04 AMI
#######################################
data "aws_ami" "ubuntu_2204" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#######################################
# Security Group: Jenkins + Monitoring
#######################################

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and web access for Jenkins/Prometheus/Grafana"
  vpc_id      = var.vpc_id

  # SSH
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # Jenkins (8080)
  ingress {
    description = "Jenkins Web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # Prometheus (9090)
  ingress {
    description = "Prometheus UI"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # Grafana (3000)
  ingress {
    description = "Grafana UI"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # Node exporter (9100)
  ingress {
    description = "Node exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

# App (Flask demo on 5000)
  ingress {
    description = "Demo app on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }


egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "jenkins-sg"
    Environment = var.environment
  }
}

#######################################
# SSH Key Pair
#######################################

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-aws-key"
  public_key = var.public_key

  tags = {
    Name        = "jenkins-aws-key"
    Environment = var.environment
  }
}

#######################################
# EC2 Instance: Jenkins + Monitoring Host
#######################################

resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  key_name                    = aws_key_pair.jenkins_key.key_name
  associate_public_ip_address = true

  tags = {
    Name        = "jenkins-devops-host"
    Environment = var.environment
    Role        = "jenkins-prometheus-grafana"
  }
}
