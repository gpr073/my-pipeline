provider "aws" {
    region = "us-east-1"
}

variable all {
    default = "0.0.0.0/0"
}

resource "aws_security_group" "myapp-sg" {
  name = "myapp-sg"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.all]
  }

  ingress {
    from_port = 8081
    to_port = 8081
    protocol = "tcp"
    cidr_blocks = [var.all]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = [var.all]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all]
  }

  tags = {
    Name = "dev-sg"
  }
}

data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_iam_instance_profile" "my_instance_profile" {
    name = "my_instance_profile"
    role = "${aws_iam_role.my_role_identifier}"
}

resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = "us-east-1b"

  associate_public_ip_address = true
  key_name = "newkey"
  iam_instance_profile = "${aws_iam_instance_profile.my_instance_profile.name}"

  user_data = file("entry-script.sh")

  tags = {
    Name = "dev-server"
  }
}

output "ec2-public-ip" {
  value = aws_instance.myapp-server.public_ip
}