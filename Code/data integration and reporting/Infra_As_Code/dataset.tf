resource "google_bigquery_dataset" "exo_dataset" {
  dataset_id  = "${replace(local.project_id,"-","_")}_bqd_${var.dataset_id}"
  location    = var.location_dataset
  description = var.description_dataset

  labels = {
    "label-key" = "label-value"
  }
}