module "minikube" {
  source = "github.com/scholzj/terraform-aws-minikube"

  aws_region    = "us-east-1"
  cluster_name  = "roboshop"
  aws_instance_type = "t3.medium"
  ssh_public_key = "~/devi.pub"
  # ~ --> home dir /c/Users/Admin, you should have devi.pub in your home
  aws_subnet_id = "subnet-0a3fee2bcc8efbbc0" # default vpc us-east-1a subnet id. can take any public subnet in any VPC, I am using default VPC here
  # ami_image_id = "ami-b81dbfc5" # iam not giving, by default it will consider centos
  hosted_zone = "devidevops.online"
  hosted_zone_private = false

  tags = {
    Application = "Minikube"
  }

  addons = [
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
  ]
}