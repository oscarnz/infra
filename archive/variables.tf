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

variable "subnet_id_1" {
  description = "subnet id 1"
  type        = string
  default     = "subnet-05568fc56f5f0f344"
}

variable "subnet_id_2" {
  description = "subnet id 2"
  type        = string
  default     = "subnet-079fb83f0872fcdfa"
}