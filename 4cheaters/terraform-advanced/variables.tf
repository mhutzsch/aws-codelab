variable "profile" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
  default = "172.16.0.0/16"
}

variable "subnet_cidrs" {
  type = "list"
  default = [
    "172.16.0.0/21",
    "172.16.8.0/21",
    "172.16.16.0/21"
  ]
}
