terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "ran_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "ahmmed-bucket-${random_id.ran_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.s3bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.s3bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.s3bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.s3bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
  acl          = null
}

resource "aws_s3_object" "css_file" {
  bucket       = aws_s3_bucket.s3bucket.bucket
  source       = "./styles.css"
  key          = "styles.css"
  content_type = "text/css"
  acl          = null
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.web_config.website_endpoint
}
