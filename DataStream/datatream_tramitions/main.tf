resource "google_datastream_stream" "site_users"{
    
    display_name          =   "${var.project_name}/${var.gcloud_region}/stream/${var.stream_users}"
	location              = var.gcloud_region
	connection_profile_id = "${var.stream_users}-${random_id.id_name.id}"


    source_config {
        source_connection_profile_name: "${var.project_name}/${var.gcloud_region}/connection_profile/${var.profile_site}"
         postgresql_source_config: {
      "allowlist": {
        " postgresqlSchemas": [
          {
            "schemaName": "site.users"
          }
        ]
      },
      "rejectlist": {}
    }


    }


    destination_config: {
    destination_connection_profile_name:  "${var.project_name}/${var.gcloud_region}/connection_profile/${var.profile_bucketmicasino}",
    gcs_destination_config: {
      "file_rotation_mb": 5,
      "file_rotation_interval": {
        "seconds": 60
      },
      "avro_file_format": {}
    }
  }


}
