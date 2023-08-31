 
 data "archive_file" "asset_export_fn" {
  type        = "zip"
  source_dir  = "sourcecode"
  output_path = "sourcecode/code.zip"
}

  #step1_google_cloud_storage_create_buckets
  resource "google_storage_bucket" "buckets_buckets" {
  name =               "buckets_functions"
  location =           "europe-west1"
  force_destroy = true
  storage_class      = "STANDARD"

 uniform_bucket_level_access = true

  }

#step2_google_storage_bucket_object
resource "google_storage_bucket_object" "archive" {
  name = "source.zip"
  bucket = google_storage_bucket.buckets_buckets.name
  source = data.archive_file.asset_export_fn.output_path
  #source = "sourcecode/code.zip"
}

#step3_google_cloud_functions

resource "google_cloudfunctions_function" "gcs_alert_finalized" {
  name        = "gcs-alert_finalized"
  description = "My function triggered by Cloud Storage"
  runtime     = "python38"
  entry_point = "hello_gcs_finalized"
  available_memory_mb          = 256
  source_archive_bucket        = google_storage_bucket.buckets_buckets.name
  source_archive_object        = google_storage_bucket_object.archive.name
  # Ajout du déclencheur
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.buckets_buckets.name
    
  }
  
  timeout   = 60
  labels = {
    my-label = "my-label-value"
  }

  environment_variables = {
    MY_ENV_VAR = "my-env-var-value"
  }
}
