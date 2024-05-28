variable "ec2_instance_type" {
  description = "Instance type to crate the resources"
  type = string   
}

variable "image_id" {
  description = "Image AMI to create the resources"
  type = string
}
