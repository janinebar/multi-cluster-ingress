# # Apply store manifest
# resource "null_resource" "command-gke-west-credential" {
#   provisioner "local-exec" {
#     command = format("gcloud container clusters get-credentials gke-west-1a --zone=us-west1-a --project=%s", var.project_id)
#   }
# }

# resource "kubectl_manifest" "store-west" {
#     yaml_body = file("${path.module}/manifests/store.yaml")
#     depends_on = [
#         null_resource.command-gke-west-credential
#     ]
# }
