####Security Group#####
resource "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}
########pem-key#####
resource "aws_key_pair" "bastion" {
  key_name = "bastion-server"
  public_key = file("~/.ssh/bastion-server.pub")
}


####EC2#####
resource "aws_instance" "bastion" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnets
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name = var.key_name
  associate_public_ip_address = true
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "demo-bastion-server"
    Project = "demo"
    Environment = "dev"
  }
}
####EIP###
resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  tags = {
    Name = "bastion-eip"
  }
}