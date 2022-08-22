# output "gke-sa" {
#     value = google_service_account.gke-node-sa.email
# }

output "cluster_list" {
    value = [google_container_cluster.gke-west-1, google_container_cluster.gke-east-1]
    # value = google_container_cluster.gke-west-1
}
