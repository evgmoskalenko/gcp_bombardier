variable "region" {
  default = "us-west1"
}

variable "project_id" {
  description = "Set project id from credentials.json file"
  type        = string
  default     = "terraform-342610"
}

variable "vm_count" {
  description = "Set vm count"
  type        = number
  default     = 1
}

variable "vm_machine_type" {
  description = "Set machine type"
  type        = string
  default     = "f1-micro"
}
