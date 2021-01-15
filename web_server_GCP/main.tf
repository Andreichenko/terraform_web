provider "google" {

  credentials = file("mycreds.json")
  project = "prod-251999"
  region = "us-west1"
  zone = "us-west1-c"
}

resource "google_compute_instance" "my_server" {
  name = "my-gcp-server"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"  // this enable private ip address
    access_config {}  // this enable public ip address
  }
}

