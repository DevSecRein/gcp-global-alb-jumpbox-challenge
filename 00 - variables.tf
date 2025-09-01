variable "rdp_access_tag" {
  default = "rdp-access"
  type    = string
}

variable "private_access_tag" {
  default = "private-webserver"
  type    = string
}

variable "private_region" {
  default = "southamerica-east1"
  type    = string
}

variable "private_cidr" {
  default = "10.17.0.0/24"
  type    = string
}

variable "private_subnet_name" {
  default = "carioca"
  type    = string
}

variable "public_region" {
  default = "northamerica-south1"
  type    = string
}

variable "public_cidr" {
  default = "10.27.0.0/24"
  type    = string
}

variable "public_subnet_name" {
  default = "tapatia"
  type    = string
}

variable "app_name" {
  default = "webserver"
  type    = string
}

variable "rdp_machine_type"{
  default = "n4-standard-4"
  type    = string
}

variable "linux_server_machine_type"{
  default = "e2-medium"
  type    = string
}