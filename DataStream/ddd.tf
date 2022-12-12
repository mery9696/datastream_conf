
resource "google_storage_bucket" "whitelabels" {
  name          = var.gcs_whitelabels_bucket_name
  location      = var.gcloud_region
  force_destroy = true
  uniform_bucket_level_access = false
}
resource "google_storage_bucket" "assets" {
  name          = var.gcs_assets_bucket_name
  location      = var.gcloud_region
  force_destroy = true
  uniform_bucket_level_access = false
}
resource "google_storage_default_object_access_control" "whitelabels" {
  bucket = google_storage_bucket.whitelabels.name
  role   = "READER"
  entity = "allUsers"
}
resource "google_storage_default_object_access_control" "assets" {
  bucket = google_storage_bucket.assets.name
  role   = "READER"
  entity = "allUsers"
}
resource "google_storage_bucket_iam_binding" "whitelabels" {
  bucket   = google_storage_bucket.whitelabels.name
  role     = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.storage.email}",
  ]
  lifecycle {
    ignore_changes = [
      # @todo Remove this after migration!
      members,
    ]
  }
}
resource "google_storage_bucket_iam_binding" "assets" {
  bucket   = google_storage_bucket.assets.name
  role     = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.storage.email}",
  ]
}
resource "google_storage_hmac_key" "storage" {
  service_account_email = google_service_account.storage.email
}