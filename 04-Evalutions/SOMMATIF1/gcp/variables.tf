variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where resources will be deployed"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "The name of the Compute Engine instance"
  type        = string
  default     = "my-instance"
}

variable "machine_type" {
  description = "The type of machine to use for the Compute Engine instance"
  type        = string
  default     = "n1-standard-1"
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket"
  type        = string
}