# Module for IAM Role
module "iam" {
  source = "./iam"
  image_id = var.image_id
  ec2_instance_type = var.ec2_instance_type  
}

