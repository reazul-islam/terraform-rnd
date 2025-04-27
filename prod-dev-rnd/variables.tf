variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}
variable "access_key" {
  description = "Environment name (dev/prod)"
  type        = string
}
variable "secret_key" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy resources"
  type        = string
  default     = null
}