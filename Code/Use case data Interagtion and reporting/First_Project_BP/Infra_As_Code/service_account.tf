/*
* Service Account
*/
resource "google_service_account" "service_acc" {
  for_each     = var.service_accs
  account_id   = "sac-${lower(each.value.purpose)}"
  display_name = each.value.display_name
  description  = each.value.description
}
