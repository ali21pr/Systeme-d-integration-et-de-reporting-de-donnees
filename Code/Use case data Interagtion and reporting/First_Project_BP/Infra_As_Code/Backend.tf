terraform {
  backend "gcs" {
    bucket  = "bucket_temporaire"
    prefix  = "terraform"
  }
}
