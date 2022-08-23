terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}


## WORKING 
resource "kubectl_manifest" "gateway-classes" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_gatewayclasses.yaml")
    provider = kubectl
}

resource "kubectl_manifest" "gateways" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_gateways.yaml")
    provider = kubectl
}

resource "kubectl_manifest" "http-routes" {
    yaml_body = file("${path.module}/manifests/gateway.networking.k8s.io_httproutes.yaml")
    provider = kubectl
}