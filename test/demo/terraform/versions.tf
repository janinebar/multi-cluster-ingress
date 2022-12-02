terraform {
  required_version = ">= 1.1.5"
  required_providers {
    # google = {
    #   source  = "hashicorp/google"
    #   version = "~> 3.48.0"
    # }
    # google-beta = {
    #   source = "hashicorp/google-beta"
    #   version = "~> 4.10.0"
    # }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }    
    kustomization = {
      source  = "kbst/kustomize"
      version = "0.2.0-beta.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}