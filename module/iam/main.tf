#create iam ploicy
resource "aws_iam_policy" "example_policy_123" {
  name = "eaxample_policy_123"
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
resource "aws_iam_role" "example_role_jenkins" {
  name = "example_role_jenkins"
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
  name = "example_policy_attachment_123"
  roles = [aws_iam_role.example_role_jenkins.name]
  policy_arn = aws_iam_policy.example_policy_123.arn
}

#create instance profile using role
resource "aws_iam_instance_profile" "example_profile_12" {
  name = "example_profile_12"
  role = aws_iam_role.example_role_jenkins.name  
}

#create EC2 instance and attache iam role
resource "aws_instance" "example_instance" {
  instance_type = var.ec2_instance_type
  ami = var.image_id
  iam_instance_profile = aws_iam_instance_profile.example_profile_12.name  
  
  tags = {
    name = "my-instance"
  }
}

