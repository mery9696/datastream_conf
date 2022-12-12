resource "google_datastream_stream" "site_users"{
    
    display_name          =   "${var.project_name}/${var.gcloud_region}/stream/${var.stream_users}"
	location              = var.gcloud_region
	connection_profile_id = "${var.stream_users}-${random_id.id_name.id}"


    source_config {
        source_connection_profile_name: "[PROJECT_PATH]/connectionProfiles/[SOURCE_CONNECTION_PROFILE_ID]"
        mysql_source_config: {
      "allowlist": {
        "mysqlSchemas": [
          {
            "schemaName": "site.users"
          }
        ]
      },
      "rejectlist": {}
    }


    }


    destination_config: {
    destination_connection_profile_name: "[PROJECT_PATH]/connectionProfiles/[DESTINATION_CONNECTION_PROFILE_ID]",
    gcs_destination_config: {
      "file_rotation_mb": 5,
      "file_rotation_interval": {
        "seconds": 18
      },
      "avro_file_format": {}
    }
  }






}
  "display_name": "[DISPLAY_NAME]",
  "source_config": {
    "source_connection_profile_name": "[PROJECT_PATH]/connectionProfiles/[SOURCE_CONNECTION_PROFILE_ID]",
    "oracle_source_config": {
      "allowlist": {
        "oracleSchemas": [
          {
            "schemaName": "ROOT"
          }
        ]
      },
      "rejectlist": {}
    }
  },
  "destination_config": {
    "destination_connection_profile_name": "[PROJECT_PATH]/connectionProfiles/[DESTINATION_CONNECTION_PROFILE_ID]",
    "gcs_destination_config": {
      "file_rotation_mb": 5,
      "file_rotation_interval": {
        "seconds": 15
      },
      "avro_file_format": {}
    }
  },
  "backfill_all": {}
}