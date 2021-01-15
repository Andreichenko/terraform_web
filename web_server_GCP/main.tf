provider "google" {

  credentials = file("mycreds.json")
  project = "prod-251999"
  region = "us-west1"
  zone = "us-west1-c"
}

