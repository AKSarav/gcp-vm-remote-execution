/*
This is a test server definition for GCE+Terraform for GH-9564
*/

provider "google" {
  project = var.projectt
  region  = var.region
}

resource "google_compute_instance" "dev" {
  name         = "devserver" # name of the server
  machine_type = "e2-micro" # machine type refer google machine types
  zone         = "${var.region}-a" # `a` zone of the selected region in our case us-central-1a
  tags         = ["externalssh","webserver"] # selecting the vm instances with tags

  # to create a startup disk with an Image/ISO. 
  # here we are choosing the CentOS7 image
  boot_disk { 
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  # We can create our own network or use the default one like we did here
  network_interface {
    network = "default"

    # assigning the reserved public IP to this instance
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  
    inline = [
      "sudo yum -y install epel-release",
      "sudo yum -y install nginx",
      "sudo nginx -v"
    ]
  }
  
}