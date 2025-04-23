resource "aws_iam_role" "iam-role" {
  name               = var.iam-role
  assume_role_policy = <<EOF
{
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
}
EOF
}

#  resource "aws_iam_role" "iam-role" {  --> This line defines a new AWS IAM role resource in Terraform. The resource type is aws_iam_role, and "iam-role" is the name Terraform uses to reference this resource in other parts of the code (like in ec2.tf).
# name = var.iam-role --> This sets the name of the IAM role by using a variable called iam-role, which is defined in variables.tf as "Jenkins-iam-role". The role will be named Jenkins-iam-role in AWS.
# assume_role_policy = <<EOF  -> This specifies the trust policy for the IAM role. The assume_role_policy defines who or what can assume (use) the role. The <<EOF is the start of a multi-line string in Terraform, and it marks the beginning of the policy definition.
# "Version": "2012-10-17" -> Specifies the version of the IAM policy language. "2012-10-17" is the current version of the policy language and is commonly used.
# "Statement" -> This block defines the policy statements, which are the actual permissions or trust rules. It’s an array because you can have multiple statements.
#  "Effect": "Allow" -> This specifies that the action described in the statement is allowed. You can also specify "Deny" in other contexts, but in this case, we are allowing the role to be assumed.
# "Principal": -> This defines who or what can assume the role. The Principal is the entity that is granted the permission to assume the role.
# "Service": "ec2.amazonaws.com" -> the Principal is ec2.amazonaws.com, which means this role can be assumed by EC2 instances. Essentially, it allows EC2 instances to assume the role.
# "Action": "sts:AssumeRole" -> This line specifies the action that is allowed, which is sts:AssumeRole. This action grants the EC2 instance permission to assume the IAM role.
# 
# 










