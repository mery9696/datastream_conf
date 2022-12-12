
resource "google_storage_bucket" "MicasinoBi" {
	name          = var.gcs_bucket_name
	location      = var.gcloud_region
	force_destroy = false
	uniform_bucket_level_access = false
  }

  resource "google_storage_default_object_access_control" "MicasinoBi" {
	bucket = google_storage_bucket.MicasinoBi.name
	role   = "READER"
	entity = "allUsers"
  }


  resource "google_storage_bucket_iam_binding" "MicasinoBi" {
	bucket   = google_storage_bucket.MicasinoBi.name
	role     = "roles/storage.objectAdmin"
	members = [
	  "serviceAccount:${google_service_account.storage.email}",
	]
	}


  resource "google_storage_hmac_key" "storage" {
	service_account_email = google_service_account.storage.email
  }