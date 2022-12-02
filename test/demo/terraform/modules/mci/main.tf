# ----------------------------------------------------------------------------------------------------------------------
# Configure Multi-Cluster Ingress
# ----------------------------------------------------------------------------------------------------------------------
resource "google_gke_hub_feature" "mci" {
  name = "multiclusteringress"
  location = "global"
  spec {
    multiclusteringress {
      config_membership = "projects/${var.project_id}/locations/global/memberships/${var.gke-cluster-name}"
    }
  }
  provider = google-beta
}

# Set correct service account roles
resource "google_project_iam_member" "mcs_service_account-roles" {
    role    = "roles/container.admin"
    member  = "serviceAccount:service-${var.project_number}@gcp-sa-multiclusteringress.iam.gserviceaccount.com"
    project = var.project_id

    depends_on = [
        google_gke_hub_feature.mci
        ]
}
