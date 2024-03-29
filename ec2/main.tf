data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "devops-practice-with-ansible"
  owners      = [data.aws_caller_identity.current.account_id]

}

resource "aws_instance" "ec2" {
  ami = "ami-03265a0778a880afb"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    name = var.component
  }
}

resource "null_resource" "provisioner" {
  provisioner "remote-exec" {

    connection {
      host = aws_instance.ec2.public_ip
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/hyder18/roboshop-ansible roboshop.yml -e role_name=${var.component}"
    ]
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z05481573J6LJA916DTHH"
  name    = "${var.component}-dev.hyder71.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

variable "component" {}
variable "instance_type" {}


variable "env" {
  default = "dev"
}

