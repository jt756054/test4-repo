variable "bucket" {
  description = "s3 bucket name"
  type = string
}
variable "tags" {
  description = "s3 buck tag"
  type = map(string)
}

##network
variable "vpc-cidr-block" {
  type = string
}
variable "instance_tenancy" {
  type = string
}
variable "vpc_tags" {
  type = map(string)
}


variable "acme-retail-az" {
  type = list(string)
}
variable "acme-retail-public-cidr" {
  type = list(string)
}
variable "acme-retail-private-cidr" {
  type = list(string)
}
##vpc sg
variable "vpc-ingress" {
  type = list(object({
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_block  = list(string)
    }))
}
variable "vpc-egress" {
  type = list(object({
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_block  = list(string)
    }))
}