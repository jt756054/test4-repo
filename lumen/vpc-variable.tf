/* locals {
  environment = "dev"
}

variable "cidr_block" {
  type        = string
  description = "sumens vpc cidr block"
}

variable "instance_tenancy" {
  type = string
}

##creating public subnets var
variable "public_subnet_cidr" {
  description = "sumens vpc public subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "igw" {
  description = "route to the internet"
  type        = string
  default     = "0.0.0.0/0"
}

##creating private subnet var
variable "private_subnet_cidr" {
  description = "private subnet cidr block"
  type = map(object({
    cidr = string
    az   = string
  }))
}

*/