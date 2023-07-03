data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]

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
         "git clone https://github.com/hyder18/roboshop-shell",
         "cd roboshop-shell",
         " sudo bash ${var.component}.sh ${var.password}"
       ]
     }
   }



resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "ALL"
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

variable "password" {}