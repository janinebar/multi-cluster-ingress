# ----------------------------------------------------------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  type        = string
  description = "project id required"
}

variable "project_number" {
 type        = string
 description = "project number in which demo deploy"
}

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
        "container.googleapis.com",
        "gkeconnect.googleapis.com",
        "gkehub.googleapis.com",
        "iam.googleapis.com",
        "multiclusterservicediscovery.googleapis.com",
        "multiclusteringress.googleapis.com",
        "trafficdirector.googleapis.com",
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

variable "project_name" {
 type        = string
 description = "project name in which demo deploy"
}
variable "gcp_account_name" {
 description = "user performing the demo"
}
variable "deployment_service_account_name" {
 description = "Cloudbuild_Service_account having permission to deploy terraform resources"
}
variable "org_id" {
 description = "Organization ID in which project created"
}
variable "data_location" {
 type        = string
 description = "Location of source data file in central bucket"
}
variable "secret_stored_project" {
  type        = string
  description = "Project where secret is accessing from"
}