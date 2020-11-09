variable "region" {}
variable "region_name" {}

variable "vpc_cidr" {}

variable "private-subnet1" {}
variable "private-subnet2" {}
variable "private-subnet3" {}

variable "public-subnet1" {}
variable "public-subnet2" {}
variable "public-subnet3" {}

variable "public_route_table_cidr" {}

variable "az1" {}
variable "az2" {}
variable "az3" {}

variable "tags" {
  type = "map"
}
