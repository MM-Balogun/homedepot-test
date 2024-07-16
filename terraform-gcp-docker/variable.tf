variable "project_id" {
  description = "The ID of the project in which to create the instance."
  type        = string
}

variable "region" {
  description = "The region in which to create the instance."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which to create the instance."
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "The name of the instance."
  type        = string
  default     = "terraform-instance"
}

variable "machine_type" {
  description = "The machine type to use for the instance."
  type        = string
  default     = "e2-medium"
}
