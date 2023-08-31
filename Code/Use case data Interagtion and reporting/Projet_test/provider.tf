terraform {
 required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.45.0"
   }
 }

}
 provider "google" {
  project     = "kyr-sandbox-test-abo"
  region      = "europe-west1"
  
}