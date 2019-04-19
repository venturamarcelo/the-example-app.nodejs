variable "app_name" {
  default = "ssfdata"
}

variable "template_name" {
  default = "tf-test-template-config"
}

variable "stack_name" {
  default = "64bit Amazon Linux 2018.03 v4.8.2 running Node.js"
}

variable "dev_env" {
  default     = "dev-env"
  description = "Development environment"
}

variable "qa_env" {
  default     = "qa-env"
  description = "QA environment"
}

variable "prod_env" {
  default     = "prod-env"
  description = "Production environment"
}

variable "region" {
  default     = "us-west-1"
  description = "AWS Region"
}

variable "bucket" {
  default     = "ssfdata"
  description = "AWS S3 bucket name"
}
