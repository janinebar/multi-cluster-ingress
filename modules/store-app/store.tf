# resource "kubernetes_manifest" "store" {
#     manifest = {
#         "apiVersion" =  "v1"
#         "kind" = "Namespace"
#         "metadata" = {
#             "name" = "store"
#         }
#     }
#     provider = kubernetes.gke-east
# }

# resource "kubernetes_manifest" "store" {
#     manifest = {
#         "apiVersion" = "apps/v1"
#         "kind"= "Deployment"
#         "metadata" = {
#             "name" = "store"
#             "namespace" = "store"
#         }
#         "spec" = {
#             "replicas" = "2"
#             "selector" = {
#                 "matchLabels" = {
#                 "app" = "store"
#                 "version" = "v1"
#                 }
#             }
#             "template" = {
#                 "metadata": {
#                     "labels" = {
#                         "app" = "store"
#                         "version" = "v1"
#                     }
#                 }
#                 "spec" = {
#                     "containers" = {
#                         "name" = "whereami"
#                         "image" = "gcr.io/google-samples/whereami:latest"
#                         "ports" = {
#                             "containerPort" = "8080"
#                         }
#                     }
#                 }
#             }
#         }
#     }
# }

