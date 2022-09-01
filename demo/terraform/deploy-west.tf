# ----------------------------------------------------------------------------------------------------------------------
# "gke-west-1" GKE Cluster Data/Resources
# ----------------------------------------------------------------------------------------------------------------------
data "google_container_cluster" "gke_west" {
    name = module.gke.cluster_list[0].name
    location = module.gke.cluster_list[0].location
    depends_on = [
      module.gke
    ]
}

provider "kubectl" {
    host                   = "https://${data.google_container_cluster.gke_west.endpoint}"
    cluster_ca_certificate = base64decode("${data.google_container_cluster.gke_west.master_auth.0.cluster_ca_certificate}")
    token                  = data.google_client_config.current.access_token
    alias = "gke-west"
}



# ----------------------------------------------------------------------------------------------------------------------
# Apply Manifests
# ----------------------------------------------------------------------------------------------------------------------
resource "kubectl_manifest" "store-west-ns" {
    yaml_body = file("./manifests/store.yaml")
    provider = kubectl.gke-west
    depends_on = [
        module.gke,
        module.mci
    ]
}

resource "kubectl_manifest" "store-west-deploy" {
    yaml_body = file("./manifests/store-deploy.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-ns,
        kubectl_manifest.store-east-ns
    ]
}

resource "kubectl_manifest" "store-west-service" {
    yaml_body = file("./manifests/store-service.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-deploy,
        kubectl_manifest.store-east-deploy
    ]
}

resource "kubectl_manifest" "store-west-service-export" {
    yaml_body = file("./manifests/store-service-export.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-service,
        kubectl_manifest.store-east-service
    ]
}

resource "kubectl_manifest" "store-west-service-west" {
    yaml_body = file("./manifests/west/store-west-service.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-service-export,
        kubectl_manifest.store-east-service-export
    ]
}

resource "kubectl_manifest" "store-west-service-export-west" {
    yaml_body = file("./manifests/west/store-west-service-export.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-service-west,
        kubectl_manifest.store-east-service-east
    ]
}

# Manifests for public store URL, applied only to config cluster (gke-west-1)
resource "kubectl_manifest" "external-http-gateway" {
    yaml_body = file("./manifests/west/external-http-gateway.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.store-west-service-export-west,
        kubectl_manifest.store-east-service-export-east
    ]
}

resource "kubectl_manifest" "public-store-route" {
    yaml_body = file("./manifests/west/public-store-route.yaml")
    provider = kubectl.gke-west
    depends_on = [
        kubectl_manifest.external-http-gateway
    ]
}

