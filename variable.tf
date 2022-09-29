variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}


variable "cidr-for-vpc" {
  description = "the cidr for vpc"
  type        = string
  default     = "10.0.0.0/16"
}



variable "cidr-for-public_sub1" {
  description = "the cidr for public_sub1 "
  type        = string
  default     = "10.0.1.0/24"
}


variable "cidr-for-public_sub2" {
  description = "the cidr for public_sub2 "
  type        = string
  default     = "10.0.5.0/24"
}


variable "cidr-for-private_sub1" {
  description = "the cidr for private_sub1 "
  type        = string
  default     = "10.0.3.0/24"
}




variable "cidr-for-private_sub2" {
  description = "the cidr for private_sub2 "
  type        = string
  default     = "10.0.4.0/24"
}


variable "cidr-public-igw-route" {
  description = "the cidr for public igw route"
  type        = string
  default     = "0.0.0.0/0"
}


variable "cidr-nat-gateway-route" {
  description = "the cidr for nat gateway route"
  type        = string
  default     = "0.0.0.0/0"
}


variable "instance-type" {
  description = "type of instance"
  type        = string
  default     = "t2.micro"
}


variable "ami-type" {
  description = "ami"
  type        = string
  default     = "ami-05a8c865b4de3b127"
}