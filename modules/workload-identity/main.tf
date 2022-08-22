# ----------------------------------------------------------------------------------------------------------------------
# Workload Identity GCP Setup
# ----------------------------------------------------------------------------------------------------------------------
# Kubernets service account creation in IAM
resource "google_service_account" "gke_ksa_iam" {
    account_id   = var.iam_ksa
    display_name = var.iam_ksa
}

#Bind Workload Identity permissions
resource "google_service_account_iam_member" "ksa_service_account_iap" {
    service_account_id = "${google_service_account.gke_ksa_iam.name}"
    role    = "roles/iam.workloadIdentityUser"
    member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.ksa_name}]"
    depends_on = [
        google_service_account.gke_ksa_iam
    ]
}

# Bind GCP Permissions
resource "google_project_iam_member" "ksa_service_account_roles" {
    for_each = toset(var.iam_ksa_roles)
    role    = "roles/${each.value}"
    member  = "serviceAccount:${google_service_account.gke_ksa_iam.email}"
    depends_on = [
        google_service_account.gke_ksa_iam
    ]
}