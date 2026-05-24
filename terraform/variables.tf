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

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub username for pulling images"
  type        = string
}

variable "mongo_uri" {
  description = "MongoDB URI for the application to connect to"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "Secret key for JWT authentication"
  type        = string
  sensitive   = true
}