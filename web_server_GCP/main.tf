provider "google" {

  credentials = file("mycreds.json")
  project = "prod-251999"
  region = "us-west1"
  zone = "us-west1-c"
}

resource "google_project_service" "api" {
  for_each = toset([
  "cloudresourcemanager.googleapis.com",
  "computegoogleapis.com"

  ])
  disable_on_destroy = false
  service = each.value
}

resource "google_compute_firewall" "web" {
  name = "web_access"
  network = "default"
  source_ranges = [0.0.0.0/0]
  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }
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
  metadata_startup_script = <<EOF
  #!/bin/bash
apt update -y
apt install apache2 -y
MYIP='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2> Webserver with privateIP: $MYIP</h2><br>Build by Terraform external file" > /var/www/index.html
systemctl restart apache2
EOF

  depends_on = [google_project_service.api, google_compute_firewall.web]
}

