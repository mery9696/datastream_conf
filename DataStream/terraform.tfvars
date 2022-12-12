display_name = "projects/none/location/none/privateConnections/vpc_micasino"
project     = "my-project"
gcloud_region  = "us-central1"



variable "profile_site" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {
    name= "bd_site"
  }
}




network = google_compute_network.vpc.name
subnetwork = google_compute_subnetwork.vpc_subnet.name
networking_mode = "VPC_NATIVE"
