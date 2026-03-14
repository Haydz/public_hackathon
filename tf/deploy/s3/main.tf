provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-terraform-bucket-name"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
