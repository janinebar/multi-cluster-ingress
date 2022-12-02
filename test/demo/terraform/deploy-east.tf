# ----------------------------------------------------------------------------------------------------------------------
# "gke-east-1" GKE Cluster Data/Resources
# ----------------------------------------------------------------------------------------------------------------------
data "google_container_cluster" "gke_east" {
    name = module.gke.cluster_list[1].name
    location = module.gke.cluster_list[1].location
    depends_on = [
      module.gke
    ]
}

# Used for cluster credentials


provider "kubectl" {
    host                   = "https://${data.google_container_cluster.gke_east.endpoint}"
    cluster_ca_certificate = base64decode("${data.google_container_cluster.gke_east.master_auth.0.cluster_ca_certificate}")
    token                  = data.google_client_config.current.access_token
    alias = "gke-east"
    load_config_file          = "false"
}

# ----------------------------------------------------------------------------------------------------------------------
# Apply Manifests
# ----------------------------------------------------------------------------------------------------------------------
resource "kubectl_manifest" "store-east-ns" {
    yaml_body = file("./manifests/store.yaml")
    provider = kubectl.gke-east
    depends_on = [
        module.gke,
        module.mci
    ]
}

resource "kubectl_manifest" "store-east-deploy" {
    yaml_body = file("./manifests/store-deploy.yaml")
    provider = kubectl.gke-east
    depends_on = [
        kubectl_manifest.store-east-ns,
        kubectl_manifest.store-west-ns,
    ]
}

resource "kubectl_manifest" "store-east-service" {
    yaml_body = file("./manifests/store-service.yaml")
    provider = kubectl.gke-east
    depends_on = [
        kubectl_manifest.store-east-deploy,
        kubectl_manifest.store-west-deploy
    ]
}

resource "kubectl_manifest" "store-east-service-export" {
    yaml_body = file("./manifests/store-service-export.yaml")
    provider = kubectl.gke-east
    depends_on = [
        kubectl_manifest.store-east-service,
        kubectl_manifest.store-west-service,
    ]
}

resource "kubectl_manifest" "store-east-service-east" {
    yaml_body = file("./manifests/east/store-east-service.yaml")
    provider = kubectl.gke-east
    depends_on = [
        kubectl_manifest.store-east-service-export,
        kubectl_manifest.store-west-service-export
    ]
}

resource "kubectl_manifest" "store-east-service-export-east" {
    yaml_body = file("./manifests/east/store-east-service-export.yaml")
    provider = kubectl.gke-east
    depends_on = [
        kubectl_manifest.store-east-service-east,
        kubectl_manifest.store-west-service-west
    ]
}




