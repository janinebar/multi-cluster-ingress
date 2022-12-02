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
#     name = "default"                   
#     auto_create_subnetworks = true
#     project = var.project_id
#     depends_on = [
#         google_project_service.enable-services
#     ]
# }

# ----------------------------------------------------------------------------------------------------------------------
# Configure GKE
# ----------------------------------------------------------------------------------------------------------------------
module "gke" {
  source  = "./modules/gke"

  project_id = var.project_id

  depends_on = [
    #   google_compute_network.default-vpc,
      google_project_service.enable-services
  ]
  
}

# ----------------------------------------------------------------------------------------------------------------------
# Configure Fleet Membership
# ----------------------------------------------------------------------------------------------------------------------
module "fleet" {
  source = "./modules/fleet"

  project_id = var.project_id
  for_each = {for idx,val in module.gke.cluster_list: idx => val}

  gke-cluster-name = each.value.name
  gke-cluster-id = each.value.id

  enable-mcs = true

  depends_on = [
    module.gke
  ]
}  

# ----------------------------------------------------------------------------------------------------------------------
# Configure Multi-Cluster Services 
# ----------------------------------------------------------------------------------------------------------------------
module "mcs" {
  source = "./modules/mcs"

  project_id = var.project_id

  enable-mcs = true

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
        kubectl = "kubectl.gke-west"
    }
    depends_on = [
        module.mcs,
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Configure Multi-Cluster Ingress
# ----------------------------------------------------------------------------------------------------------------------
module "mci" {
    source = "./modules/mci"

    project_id = var.project_id
    project_number = var.project_number
    gke-cluster-name = "gke-west-1"

    depends_on = [
        module.gke,
        module.fleet,
        module.mcs,
        module.gateway
    ]
}
