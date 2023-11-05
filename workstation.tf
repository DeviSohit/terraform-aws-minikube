module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation"

  instance_type          = "t2.micro"
  ami               = "ami-03265a0778a880afb" # devops practice centos 8
  vpc_security_group_ids = [aws_security_group.allow_all.id] # allow_all sec group
  subnet_id              = "subnet-0a3fee2bcc8efbbc0" # default vpc subnet
  user_data = file("docker.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all traffic for minikube"
  # vpc_id      = aws_vpc.main.id # no need to give, will take automatically default VPC

  ingress {
    description      = "Allow traffic from VPC"
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
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all_minikube"
  }
}