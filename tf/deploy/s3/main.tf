terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "by_tines" {
  bucket = "by_tines"

  tags = {
    Name        = "Tines S3 Bucket"
    Environment = "Production"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "by_tines" {
  bucket = aws_s3_bucket.by_tines.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access for security
resource "aws_s3_bucket_public_access_block" "by_tines" {
  bucket = aws_s3_bucket.by_tines.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning configuration
resource "aws_s3_bucket_versioning" "by_tines" {
  bucket = aws_s3_bucket.by_tines.id
  
  versioning_configuration {
    status = "Enabled"
  }
}