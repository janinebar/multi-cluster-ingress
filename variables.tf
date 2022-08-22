# ----------------------------------------------------------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------------------------------------------------------
# GCP Project Name
variable "project_id" {
    type = string
}

variable "project_number" {
    type = string
}
# variable "fleet-membership" {}

# variable "project"{}

variable "vpc-name" {
    type = string
    description = "Custom VPC Name"
    default = "gke-resilient-architecture"
}

# List of regions (support for multi-region deployment)
variable "regions" { 
    type = list(object({
        region = string
        # zone = string
        # cidr = string
        # management-cidr = string
        })
    )
    default = [{
            region = "us-west1"
            # cidr = "10.0.0.0/20"
            # management-cidr = "192.168.10.0/28"
        },
        # {
        #     region = "us-central1"
        #     cidr = "10.0.16.0/20"
        #     management-cidr = "192.168.11.0/28"
        # },
        {
            region = "us-east1"
            # cidr = "10.0.32.0/20"
            # management-cidr = "192.168.12.0/28"
        }]
}

# Service to enable
variable "services_to_enable" {
    description = "List of GCP Services to enable"
    type    = list(string)
    default =  [
        "compute.googleapis.com",
        "iap.googleapis.com",
        "anthos.googleapis.com",
        "anthosaudit.googleapis.com",
        "anthosgke.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "container.googleapis.com",
        "gkeconnect.googleapis.com",
        "gkehub.googleapis.com",
        "iam.googleapis.com",
        "logging.googleapis.com",
        "monitoring.googleapis.com",
        "multiclusterservicediscovery.googleapis.com",
        "multiclusteringress.googleapis.com",
        "opsconfigmonitoring.googleapis.com",
        "serviceusage.googleapis.com",
        "stackdriver.googleapis.com",
        "servicemanagement.googleapis.com",
        "servicecontrol.googleapis.com",
        "storage.googleapis.com",
        "trafficdirector.googleapis.com",
        "run.googleapis.com"
    ]
}


# Extra GKE SA Roles
variable "gke_service_account_roles" {
    description = "GKE Service Account Roles"
    type        = list(string)
    default     = [
        "gkehub.connect",
        "gkehub.admin",
        "logging.logWriter",
        "monitoring.metricWriter",
        "monitoring.dashboardEditor",
        "stackdriver.resourceMetadata.writer",
        "opsconfigmonitoring.resourceMetadata.writer",
        "multiclusterservicediscovery.serviceAgent",
        "multiclusterservicediscovery.serviceAgent",
        "compute.networkViewer",
        "container.admin",
        "source.reader"
    ]
}

# GKE Settings
variable "gke-node-count" {
    description = "GKE Inital Node Count"
    type = number
    default = 3
}

variable "gke-node-type" {
    description = "GKE Node Machine Shape"
    type = string
    default = "e2-standard-4"
}

# Deployment Info
variable "k8-namespace" {
    description = "Default name space to provision into"
    type = string
    default = "hipster"
}

# GKE Application Service account
variable "ksa_name" {
    description = "Kubernetes Service Account Name"
    type = string
    default = "hipster-ksa"
}

variable "iam_ksa" {
    description = "IAM user for KSA"
    type = string
    default = "hipster-gsa"
}