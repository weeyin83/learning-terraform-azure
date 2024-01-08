## 
# Variables
##

variable "location" {
  type    = string
  default = "uksouth"
}

variable "naming_prefix" {
  type    = string
  default = "speakinglog"
}

variable "tag_usage" {
  type    = string
  default = "speaking"
}

variable "tag_owner" {
  type    = string
  default = "sarah"
}

variable "allowed_ip_address" {
  type    = string
  default = "10.0.17.62"
}

variable "admin_user" {
  type    = string
  default = "missadministrator"
}

variable "admin_password" {
  type        = string
  description = "The administrator password of the SQL logical server."
  sensitive   = true
  default     = null
}
