# ----------------------------------------------------------------------------------------------------------------------
# Create GKE Clusters
# ----------------------------------------------------------------------------------------------------------------------
resource "google_container_cluster" "gke-west-1" {
    provider  = google-beta
    name     = "gke-west-1"
    location = "us-west1-a"

    release_channel {
        channel = "REGULAR"
    }

    workload_identity_config {
        workload_pool = "${var.project_id}.svc.id.goog"
    }

    ip_allocation_policy {}

    node_pool {
        initial_node_count = 3

        node_config {
            preemptible  = false
            # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
            oauth_scopes = [
                "https://www.googleapis.com/auth/cloud-platform"
            ]
        }
    }
    
    timeouts {
        create = "30m"
        update = "40m"
    }
    provisioner "local-exec" {
        command = format("gcloud container clusters get-credentials gke-west-1 --zone=us-west1-a --project=%s", var.project_id)
    }
    provisioner "local-exec" {
        command = format("kubectl config rename-context gke_%s_%s_%s %s",var.project_id,self.location,self.name,self.name)
    }

}

resource "google_container_cluster" "gke-east-1" {
    provider  = google-beta
    name     = "gke-east-1"
    location = "us-east1-b"
    
    ip_allocation_policy {}

    release_channel {
        channel = "REGULAR"
    }
    workload_identity_config {
        workload_pool = "${var.project_id}.svc.id.goog"
    }
    
    node_pool {
        initial_node_count = 3
        node_config {
            preemptible  = false
            oauth_scopes = [
                "https://www.googleapis.com/auth/cloud-platform"
            ]
        }
    }
    timeouts {
        create = "30m"
        update = "40m"
    }
    provisioner "local-exec" {
        command = format("gcloud container clusters get-credentials gke-east-1 --zone=us-east1-b --project=%s", var.project_id)
    }
    provisioner "local-exec" {
        command = format("kubectl config rename-context gke_%s_%s_%s %s",var.project_id,self.location,self.name,self.name)
    }
    
}