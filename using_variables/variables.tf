variable "aws_region" {
  description = "Region where you want to provision this EC2 WebServer"
  type        = string // number , bool
  default     = "ca-central-1"
}

variable "port_list" {
  description = "List of Poret to open for our WebServer"
  type        = list(any)
  default     = ["80", "443"]
}

variable "instance_size" {
  description = "EC2 Instance Size to provision"
  type        = string
  default     = "t3.micro"
}