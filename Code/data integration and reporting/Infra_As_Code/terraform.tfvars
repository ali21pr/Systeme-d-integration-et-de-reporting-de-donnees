# Compute Engine 
machine_type = "g1-small"
zone = "europe-west1-b"
name_instance = "compute"
image = "debian-cloud/debian-11"
tags  = ["iap-ssh", "iap-http"]
subnetwork = "projects/kyr-shared-xpn-nprod/regions/europe-west1/subnetworks/kyr-shared-sub-local"

# Service Accounts
service_accs = {
    compute_sa = {
        purpose = "instance-compute",
        display_name = "service account for compute engine ",
        description  = "STANDARD"
}

    func_sa = {
        purpose = "cloud-function-exo",
        display_name = "service account for cloud function EXO",
        description  = "STANDARD"
    }
}

# GCS Buckets
buckets_exo = {
    gcs_code = {
        identifier = "gcs_code"
        location = "europe-west1"
        storage_class = "STANDARD"
        versioning_enabled = "false"
    }
    gcs_exo = {
        identifier = "gcs_exo"
        location = "europe-west1"
        storage_class = "STANDARD"
        versioning_enabled = "false"
    }
}

#google cloud function 

name_func = "gcs_exo"
description = "My function triggered by Cloud Storage"
runtime     = "python38"
entry_point = "hello_gcs_finalized"
available_memory_mb  = 512
#timeout_cf = 60

#Dataset Bigquery 

dataset_id = "exo_dataset"
location_dataset   = "europe-west1"
description_dataset = "this is project test"