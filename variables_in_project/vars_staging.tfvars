aws_region    = "eu-central-3"
port_list     = ["80", "443", "8443"]
instance_size = "t2.micro"
key_pair      = "defaultkey"

tags = {
  Owner       = "Sasha Frei"
  Environment = "Staging"
  Project     = "Sync"
  Code        = "112211"
}