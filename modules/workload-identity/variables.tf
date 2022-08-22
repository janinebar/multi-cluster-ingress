variable "project_id" {}
# variable "project" {}
variable "ksa_name" {}
variable "iam_ksa" {}
variable "iam_ksa_roles" {
    description = "IAM roles for Kubernetes service account"
    type = list(string)
    default = [
        "cloudtrace.agent",
        "monitoring.metricWriter",
        "cloudsql.client",        
    ]
}
variable "namespace" {}