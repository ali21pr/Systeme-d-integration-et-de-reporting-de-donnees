
# IAM Project_level 

module "projects_iam_bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "~> 7.6"
  projects = [local.project_id]

  mode    = "additive"

  bindings = {

    "roles/logging.logWriter" = [
      "serviceAccount:${google_service_account.service_acc["func_sa"].email}"
    ]

    "roles/bigquery.jobUser" = [
      "serviceAccount:${google_service_account.service_acc["func_sa"].email}"
    ]

     "roles/storage.admin" = [
      "serviceAccount:${google_service_account.service_acc["func_sa"].email}"
    ]

  }
}

# IAM Dataset
resource "google_bigquery_dataset_iam_binding" "read_bigquery" {
  dataset_id = google_bigquery_dataset.exo_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"

  members = [
    "serviceAccount:${google_service_account.service_acc["func_sa"].email}"
  ]
}
# IAM Bucket
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.bucket_exo["gcs_exo"].name
  role = "roles/storage.legacyBucketWriter"
  members = [
    "serviceAccount:${google_service_account.service_acc["compute_sa"].email}",
    "serviceAccount:${google_service_account.service_acc["func_sa"].email}"
  ]
}
