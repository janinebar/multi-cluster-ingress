# ----------------------------------------------------------------------------------------------------------------------
# Register Clusters to Fleet
# ----------------------------------------------------------------------------------------------------------------------
resource "google_gke_hub_membership" "fleet-register" {
  provider = google-beta
  membership_id = var.gke-cluster-name
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${var.gke-cluster-id}"
    }
  }

}

# resource "google_gke_hub_membership" "west" {
#   membership_id = "fleet-membership"
#   endpoint {
#     gke_cluster {
#     #   resource_link = "//container.googleapis.com/${google_container_cluster.gke-west-1}"
#       resource_link = google_container_cluster.gke-west-1

#     }
#   }
#   project = var.project_id
#   provider = google-beta
# }

# resource "google_gke_hub_membership" "east" {
#   membership_id = "fleet-membership"
#   endpoint {
#     gke_cluster {
#     #   resource_link = "//container.googleapis.com/${google_container_cluster.gke-east-1}"
#         resource_link = google_container_cluster.gke-east-1
#     }
#   }
#   project = var.project_id
#   provider = google-beta
# }