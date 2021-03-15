aws_region    = "eu-central-1"
port_list     = ["80", "443", "8443"]
instance_size = "t3.large"
key_pair      = "DefaultKey"

tags = {
  Owner       = "Sasha Frei"
  Environment = "Prod"
  Project     = "Sync"
  Code        = "112211"
}