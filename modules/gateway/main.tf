# Use the gke-west cluster for gateway CRD

# resource "null_resource" "command-apply-gateway-crd" {
#   provisioner "local-exec" {
#     command = "kubectl --context gke-west-1 apply -k 'github.com/kubernetes-sigs/gateway-api/config/crd?ref=v0.5.0'"
#     # command = "kubectl --context ${module.gke.cluster_list[0]} apply -k 'github.com/kubernetes-sigs/gateway-api/config/crd?ref=v0.5.0'"

#   }
# }

resource "null_resource" "command-gke-west-credential" {
  provisioner "local-exec" {
    command = format("gcloud container clusters get-credentials gke-west-1a --zone=us-west1-a --project=%s", var.project_id)
  }
}


terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

# provider "kubectl" {
#     host                   = "https://${data.google_container_cluster.gke_west.endpoint}"
#     cluster_ca_certificate = base64decode("${data.google_container_cluster.gke_cluster_0.master_auth.0.cluster_ca_certificate}")
#     token                  = data.google_client_config.current.access_token
#     alias = "gke-west"
# }

# Apply gateway CRD for main cluster
# data "kubectl_path_documents" "docs" {
#     pattern = "${path.module}/manifests/*.yaml"
#     provider = kubectl
# }

# resource "kubectl_manifest" "deploy" {
#     for_each  = toset(data.kubectl_path_documents.docs.documents)
#     yaml_body = yamldecode(each.value)
#     # manifest = 
#     provider = kubectl
# }

# data "kubectl_filename_list" "manifests" {
#     pattern = "${path.module}/manifests/*.yaml"
# }

# resource "kubectl_manifest" "test" {
#     count     = length(data.kubectl_filename_list.manifests.matches)
#     yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
# }

## WORKING 
resource "kubectl_manifest" "gateway-classes" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_gatewayclasses.yaml")
    depends_on = [
        null_resource.command-gke-west-credential
    ]
}

resource "kubectl_manifest" "gateways" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_gateways.yaml")
    depends_on = [
        null_resource.command-gke-west-credential
    ]
}

resource "kubectl_manifest" "http-routes" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_httproutes.yaml")
    depends_on = [
        null_resource.command-gke-west-credential
    ]
}