

provider "google" {
  project     = var.project_name
  region      = var.gcloud_region
}


resource "random_id" "id_name" {
  byte_length = 8
}

resource "google_datastream_private_connection" "vpc_micasino" {
	display_name          = "${var.project_name}/${var.gcloud_region}/privateConnections/vpc_micasino"
	location              = var.gcloud_region
	private_connection_id = "vpc-micasino-${random_id.id_name.id}"

	labels = {
		key = "vpc_micasino"
	}

	vpc_peering_config {
		vpc = google_compute_network.vpc.id
		subnet = google_compute_subnetwork.vpc_subnet.id
	}
}
"""para pregunta: es necesario este paso si la VPC ya existe""" 
resource "google_compute_network" "vpc_default" {
	name = "google_compute_network.vpc.name"
}

resource "google_datastream_connection_profile" "bd_site" {
	display_name          =   "${var.project_name}/${var.gcloud_region}/connection_profile/${var.profile_site}"
	location              = var.gcloud_region
	connection_profile_id = "${var.profile_site}-${random_id.id_name.id}"

	postgresql_profile {

        hostname = data.terraform_remote_state.micasino.outputs.database_private_ip_address
        username =  data.terraform_remote_state.micasino.outputs.database_username
        password = data.terraform_remote_state.micasino.outputs.database_password
        database = data.terraform_remote_state.micasino.outputs.database_name
        }

	private_connectivity {
		private_connection = google_datastream_private_connection.vpc_micasino.id
	}
}


resource "google_datastream_connection_profile" "bd_wallet" {
	display_name          =   "${var.project_name}/${var.gcloud_region}/connection_profile/${var.profile_wallet}"
	location              = var.gcloud_region
	connection_profile_id = "${var.profile_wallet}-${random_id.id_name.id}"

	postgresql_profile {

        hostname = data.terraform_remote_state.micasino.outputs.database_wallet_private_ip_address
        username =  data.terraform_remote_state.micasino.outputs.database_wallet_username
        password = data.terraform_remote_state.micasino.outputs.database_wallet_password
        database = data.terraform_remote_state.micasino.outputs.database_wallet_name
        }

	private_connectivity {
		private_connection = google_datastream_private_connection.vpc_micasino.id
	}
}


resource "google_datastream_connection_profile" "bucket_micasinobi" {
    display_name          = "${var.project_name}/${var.gcloud_region}/connection_profile/${var.profile_bucketmicasino}"
    location              = var.gcloud_region
    connection_profile_id = "${var.profile_bucketmicasino}-${random_id.id_name.id}"

    gcs_profile {
        bucket    = var.profile_bucketmicasino
        root_path = "/dms_micasino"
    }
}

output "id_conection" {
  value =  ("${google_datastream_connection_profile.bd_site.display_name}: ${google_datastream_connection_profile.bd_site.connection_profile_id}")
}

 


