resource "random_integer" "sequential_number" {
  min = 20000
  max = 50000
}

resource "google_compute_instance" "Compute_engine_project" {
  name         = "${local.project_id}-gce-lnx-${var.name_instance}-${random_integer.sequential_number.result}"
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    subnetwork = var.subnetwork
  }
  tags = var.tags

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  =  google_service_account.service_acc["compute_sa"].email
    scopes = ["cloud-platform"]
  }
 }