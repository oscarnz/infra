variable "access_key" {
  description = "access_key"
  type        = string
}

variable "secret_key" {
  description = "secret_key"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
  default     = "subnet-05568fc56f5f0f344"
}