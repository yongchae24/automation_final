
variable "humber_id" {
  type = string
  default = "n01649144"
}

variable "location" {
  type        = string
  default     = "Canada Central"
}

variable "resource_group_name" {
  type = string
  default = "n01649144-RG"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "n01649144"
}

variable "subnet_id" {
  type = string
  # Removed default value to enforce passing it from the root module
}

variable "public_key" {
  type = string
  default = "/Users/yongchae.ko/.ssh/id_rsa.pub"
}

variable "private_key" {
  type = string
  default = "/Users/yongchae.ko/.ssh/id_rsa"
}

variable "vm_names" {
  type    = map(string)
  default = {
    "vm1" = "vm1"
    "vm2" = "vm2"
    "vm3" = "vm3"
  }
}

variable "common_tags" {
  type        = map(string)
}
