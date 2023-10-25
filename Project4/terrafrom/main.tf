provider "aws" {
  profile    = "default"
  region     = "us-west-1"
}



variable "awsprops" {
    type = map(string)
    default = {
    region = "us-east-1"
    vpc = "vpc-fe0f3999"
    ami = "ami-0f8e81a3da6e2510a"
    itype = "t2.micro"
    subnet = "subnet-68142933"
    publicip = true
    keyname = "ahmedkey"
    secgroupname = "devops-Sec-Group"
  }
}

resource "aws_security_group" "project4-sec-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "master01_instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.project4-sec-sg.id
  ]
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="MASTER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Project= "devops-command-center"
  }

  depends_on = [ aws_security_group.project4-sec-sg ]
}

resource "aws_instance" "node01_instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.project4-sec-sg.id
  ]
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="NODE01"
    Environment = "DEV"
    OS = "UBUNTU"
    Project= "devops-command-center"
  }

  depends_on = [ aws_security_group.project4-sec-sg ]
}

resource "aws_instance" "node02_instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") 
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.project4-sec-sg.id
  ]
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="NODE02"
    Environment = "DEV"
    OS = "UBUNTU"
    Project= "devops-command-center"
  }

  depends_on = [ aws_security_group.project4-sec-sg ]
}

output "ec2instance_master01_instance" {
  value = aws_instance.master01_instance.public_ip
}

output "ec2instance_node01_instance" {
  value = aws_instance.node01_instance.public_ip
}

output "ec2instance_node02_instance" {
  value = aws_instance.node02_instance.public_ip
}

