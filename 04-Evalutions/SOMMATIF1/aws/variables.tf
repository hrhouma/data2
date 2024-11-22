variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
  type        = string
}