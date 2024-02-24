variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  validation {
    condition     = can(regex("vpc-[a-z0-9]+", var.vpc_id))
    error_message = "The VPC ID must be in the format 'vpc-...'"
  }
}

variable "conf_name" {
  description = "The name of the configuration"
  type        = string
  validation {
    condition     = length(var.conf_name) > 0
    error_message = "The configuration name must not be empty"
  }
}

variable "external_cidrs" {
  description = "The list of external CIDRs that should be able to access the system"
  type        = list(string)
  default     = []
}

variable "external_groups" {
  description = "The list of external security groups that should be able to access the system"
  type        = list(string)
  default     = []
}
