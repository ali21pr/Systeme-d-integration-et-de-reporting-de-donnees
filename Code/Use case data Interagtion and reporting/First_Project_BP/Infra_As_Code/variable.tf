# compute Engine 
variable "machine_type" {
  type = string
}
variable "name_instance" {
  type = string
}
variable "zone" {
  type = string
}
variable "image" {
  type = string
}
variable "tags" {
  type = list(string)
}
variable "subnetwork" {
  type = string
}

# Service Account
variable "service_accs" {
    type = map(object({
    purpose      = string
    display_name = string
    description  = string
  }))
}

# Bucket
variable "buckets_exo" {
    type = map(object({
    identifier = string
    location = string
    storage_class = string
    versioning_enabled = bool
  }))
}

#google cloud function 

variable "name_func" {
    type = string
}
variable "description" {
    type = string
}
variable "runtime" {
    type = string
}
variable "entry_point" {
    type = string
}
variable "available_memory_mb" {
    type = number
}
/*
variable "timeout_cf " {
    type = number
}
*/
#Dataset Bigquery 
variable "dataset_id" {
    type = string
}
variable "location_dataset" {
    type = string
}
variable "description_dataset" {
    type = string
}