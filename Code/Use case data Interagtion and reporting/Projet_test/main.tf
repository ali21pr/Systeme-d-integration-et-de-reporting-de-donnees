/*************************************************
           Function source code
*************************************************/
data "archive_file" "asset_export_fn" {
  type        = "zip"
  source_dir  = "sourcecode"
  output_path = "sourcecode/code.zip"
}
resource "google_compute_instance" "Compute_engine_project" {
  name         = "test"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = "projects/kyr-shared-xpn-nprod/global/networks/kyr-shared-vpc-nprod"
    subnetwork = "projects/kyr-shared-xpn-nprod/regions/europe-west1/subnetworks/kyr-shared-sub-local"
  }
  tags = ["iap-ssh"]

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "126625781174-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
 }

 resource "google_storage_bucket" "bucket_projet" {
  name =               "bucket_projet_ali"
  location =           "europe-west1"
  force_destroy = true
  storage_class      = "STANDARD"

  uniform_bucket_level_access = true
 #allow_stopping_for_update = true
}

#step2_google_storage_bucket_object
resource "google_storage_bucket_object" "archiver" {
  name = "source.zip"
  bucket = google_storage_bucket.bucket_projet.name
  source = data.archive_file.asset_export_fn.output_path
}

resource "google_bigquery_dataset" "my_dataset" {
  dataset_id                  = "my_dataset"
  location                    = "europe-west1"
  description                 = "this is project test"
  default_partition_expiration_ms = 86400000 # 1 day

  labels = {
    "label-key" = "label-value"
  }
}

/*************************************************
           step4_google_cloud_functions
*************************************************/
resource "google_cloudfunctions_function" "gcs_alert_finalized" {
  name        = "gcs-alert_finalized"
  description = "My function triggered by Cloud Storage"
  runtime     = "python38"
  entry_point = "hello_gcs_finalized"
  available_memory_mb          = 256
  source_archive_bucket        = google_storage_bucket.bucket_projet.name
  source_archive_object = google_storage_bucket_object.archiver.name
  # Ajout du déclencheur
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.bucket_projet.name
  }
  
  timeout                      = 60
  labels = {
    my-label = "my-label-value"
  }

  environment_variables = {
    MY_ENV_VAR = "my-env-var-value"
  }
}
