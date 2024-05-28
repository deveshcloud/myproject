#create iam ploicy
resource "aws_iam_policy" "example_policy" {
  name = "eaxample_policy"
  description = "permission for ec2"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
})
}

#create iam role
resource "aws_iam_role" "example_role" {
  name = "example_role"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})
}

#Attach iam policy to iam role
resource "aws_iam_policy_attachment" "policy_attach" {
  name = "example_policy_attachment"
  roles = [aws_iam_role.example_role.name]
  policy_arn = aws_iam_policy.example_policy.arn
}

#create instance profile using role
resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.example_role.name  
}

#create EC2 instance and attache iam role
resource "aws_instance" "example_instance" {
  instance_type = var.ec2_instance_type
  ami = var.image_id
  iam_instance_profile = aws_iam_instance_profile.example_profile.name  
  
  tags = {
    name = "my-instance"
  }
}

