# ----------------------------------------------------------------------------------------------------------------------
# Configure Providers
# ----------------------------------------------------------------------------------------------------------------------
provider "google" {
  region        = var.regions[0].region
  project       = var.project_id
}

provider "google-beta" {
  region        = var.regions[0].region
  project       = var.project_id
}

# ----------------------------------------------------------------------------------------------------------------------
# DATA
# ----------------------------------------------------------------------------------------------------------------------
data "google_project" "project" {}
data "google_client_config" "current" {}


# ----------------------------------------------------------------------------------------------------------------------
# Enable APIs
# ----------------------------------------------------------------------------------------------------------------------
resource "google_project_service" "enable-services" {
  for_each = toset(var.services_to_enable)

  project = var.project_id
  service = each.value
  disable_on_destroy = false
}

# ----------------------------------------------------------------------------------------------------------------------
# Create VPC
# ----------------------------------------------------------------------------------------------------------------------
# resource "google_compute_network" "default-vpc" {
#     name = "default1"                   
#     auto_create_subnetworks = true
# }

# ----------------------------------------------------------------------------------------------------------------------
# Configure GKE
# ----------------------------------------------------------------------------------------------------------------------
module "gke" {
  source  = "./modules/gke"

  project_id = var.project_id

#   depends_on = [
#       google_compute_network.default-vpc
#   ]
#   project = var.project_id
#   regions = var.regions
#   gke_service_account_roles = var.gke_service_account_roles
#   gke-node-count = var.gke-node-count
#   gke-node-type = var.gke-node-type
  
}

# ----------------------------------------------------------------------------------------------------------------------
# Configure Workload Identity # already enabled ?
# ----------------------------------------------------------------------------------------------------------------------
# module "workload-identity" {
# #   source = "./modules/workload-identity"
#   source    = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#   name      = "demo"
#   namespace = "default"
#   project   = var.project_id


#   project_id = var.project_id
#   ksa_name = var.ksa_name
#   iam_ksa = var.iam_ksa
#   namespace = var.k8-namespace

#   depends_on = [
#     module.gke
#   ]
#}




# ----------------------------------------------------------------------------------------------------------------------
# Configure Fleet Membership
# ----------------------------------------------------------------------------------------------------------------------
module "fleet" {
  source = "./modules/fleet"

  project_id = var.project_id
  for_each = {for idx,val in module.gke.cluster_list: idx => val}

  gke-cluster-name = each.value.name
  gke-cluster-id = each.value.id

  
#   vpc-name = var.vpc-name
#   project-number = data.google_project.project.number
#   gke-sa = module.gke.gke-sa

#   enable-mci = false
  enable-mcs = true
#   enable-acm = false

  depends_on = [
    module.gke
  ]
}  

# ----------------------------------------------------------------------------------------------------------------------
# Configure MCS 
# ----------------------------------------------------------------------------------------------------------------------
module "mcs" {
  source = "./modules/mcs"

  project_id = var.project_id
#   for_each = {for idx,val in module.gke.cluster_list: idx => val}

#   gke-cluster-name = each.value.name
#   gke-cluster-id = each.value.id

  
#   vpc-name = var.vpc-name
#   project-number = data.google_project.project.number
#   gke-sa = module.gke.gke-sa

#   enable-mci = false
  enable-mcs = true
#   enable-acm = false

  depends_on = [
    module.gke,
    module.fleet
  ]
} 

# ----------------------------------------------------------------------------------------------------------------------
# Configure Gateway
# ----------------------------------------------------------------------------------------------------------------------
module "gateway" {
    source = "./modules/gateway"
    project_id = var.project_id
    providers = {
        kubectl = kubernetes.gke-west
    }
    depends_on = [
        module.mcs,
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Configure MCI
# ----------------------------------------------------------------------------------------------------------------------
module "mci" {
    source = "./modules/mci"

    # fleet-membership = google_gke_hub_membership.membership
    project_id = var.project_id
    project_number = var.project_number
    gke-cluster-name = "gke-west-1a"

    depends_on = [
        module.gke,
        module.fleet,
        module.mcs,
        module.gateway
    ]
}
