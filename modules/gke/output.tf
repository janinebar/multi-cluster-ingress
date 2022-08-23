output "cluster_list" {
    value = [google_container_cluster.gke-west-1, google_container_cluster.gke-east-1]
}
