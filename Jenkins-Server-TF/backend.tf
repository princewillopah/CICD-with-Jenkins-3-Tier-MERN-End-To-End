terraform {
  backend "s3" {
    bucket         = "my-ews-baket1"
    region         = "eu-north-1"
    key            = "End-to-End-Kubernetes-Three-Tier-DevSecOps-Project/Jenkins-Server-TF/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}


/*
You need to create both the S3 bucket and the DynamoDB table beforehand if they are not already created. Terraform doesn't automatically create the backend resources (like the S3 bucket and DynamoDB table) when you define them in the backend.tf. These resources must exist before running Terraform with this configuration. Here's why:

S3 Bucket:
Terraform uses the S3 bucket to store the state file. If the bucket doesn't exist, Terraform won't be able to store or access the state file, and you will get an error.
You can either create the bucket manually via the AWS Console, CLI, or by using a separate Terraform configuration to create it.

DynamoDB Table:
The DynamoDB table is used for state locking. This ensures that only one instance of Terraform can modify the state at a time, preventing potential conflicts when multiple users or processes run Terraform simultaneously.
Similar to the S3 bucket, the DynamoDB table must be created before running Terrafo
-------------------
Creating an S3 Bucket via AWS CLI:
    - aws s3api create-bucket --bucket my-ews-baket1 --region eu-north-1

Creating a DynamoDB Table via AWS CLI:
aws dynamodb create-table \
    --table-name Lock-Files \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST

-------------------------------------------
Using terraform to create the S3 nad Dynamo
-------------------------------------------
To create the S3 bucket and DynamoDB table using Terraform, you can set up two resources in your Terraform configuration before configuring the backend. Here's how you can define them:

 S3 Bucket Definition (for storing the state file):
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-ews-baket1"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "TerraformStateBucket"
  }
}

- bucket: The name of the S3 bucket (replace "my-ews-baket1" with your preferred name).
- acl: Sets access control. "private" ensures no public access.
- versioning: Enables versioning to protect against accidental deletions or modifications.
- lifecycle: Prevents accidental deletion of the bucket.

DynamoDB Table Definition (for state locking):
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "Lock-Files"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "TerraformStateLockTable"
  }
}


name: The name of the DynamoDB table (in this case, "Lock-Files").
billing_mode: "PAY_PER_REQUEST" means you're only charged based on the requests made, which is ideal for low-throughput tables like Terraform locks.
hash_key: The key for locking (using "LockID" as the key).
attribute: Specifies the attribute definition, with type = "S" meaning it's a string type.







*/