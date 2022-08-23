# terraform {
#   required_providers {
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = "1.14.0"
#     }
#   }
# }

# # Apply store manifest
# resource "null_resource" "command-gke-east-credential" {
#   provisioner "local-exec" {
#     command = format("gcloud container clusters get-credentials gke-east-1 --zone=us-east1-b --project=%s", var.project_id)
#   }
# }

# # module "gke_east_auth" {
# #   source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"

# #   project_id           = var.project_id
# #   cluster_name         = "gke-east-1"
# #   location             = "us-east1-b"
# #   use_private_endpoint = true
# # }

# resource "kubectl_manifest" "store-east" {
#     yaml_body = file("${path.module}/manifests/store.yaml")

#     provider = kubernetes.gke-east
#     depends_on = [
#         module.gke_east_auth
#     ]
# }

# resource "kubectl_manifest" "store-east-service" {
#     yaml_body = file("${path.module}/manifests/store-east-service.yaml")
#     depends_on = [
#         kubectl_manifest.store-east
#     ]
# }
