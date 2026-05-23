variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "ecommerce-key-pair"
}