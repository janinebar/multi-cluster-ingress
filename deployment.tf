# ----------------------------------------------------------------------------------------------------------------------
# Data / Resource Creation
# ---------------------------------------------------------------------------------------------------------------------
data "google_container_cluster" "gke_west" {
    # name = module.gke.cluster_list[var.regions[0].region].name
    # location = module.gke.cluster_list[var.regions[0].region].location
    name = module.gke.cluster_list[0].name
    location = module.gke.cluster_list[0].location

    depends_on = [
      module.gke
    ]
}

data "google_container_cluster" "gke_east" {
    # name = module.gke.cluster_list[var.regions[1].region].name
    # location = module.gke.cluster_list[var.regions[1].region].location
    name = module.gke.cluster_list[1].name
    location = module.gke.cluster_list[1].location

    depends_on = [
      module.gke
    ]
}

provider "kubernetes" {
    host                   = "https://${data.google_container_cluster.gke_west.endpoint}"
    cluster_ca_certificate = base64decode("${data.google_container_cluster.gke_cluster_0.master_auth.0.cluster_ca_certificate}")
    token                  = data.google_client_config.current.access_token
    alias = "gke-west"
}

provider "kubernetes" {
    host                   = "https://${data.google_container_cluster.gke_east.endpoint}"
    cluster_ca_certificate = base64decode("${data.google_container_cluster.gke_cluster_1.master_auth.0.cluster_ca_certificate}")
    token                  = data.google_client_config.current.access_token
    alias = "gke-east"
}

# ----------------------------------------------------------------------------------------------------------------------
# Manifests
# ----------------------------------------------------------------------------------------------------------------------
# module "gateway-manifest" {
#   source = "./modules/manifests"

#   project_id = var.project_id
# #   iam_ksa = var.iam_ksa
# #   ksa_name = var.ksa_name
# #   namespace = var.k8-namespace
#   gke-cluster-name = module.gke.cluster_list[var.regions[0].region].name
#   gke-cluster-location = module.gke.cluster_list[var.regions[0].region].location

#   providers = {
#     kubernetes =  kubernetes.gke-west
#   }

#   depends_on = [
#     module.gke,
#     module.fleet,
#     module.mcs
#   ]
# }


 

