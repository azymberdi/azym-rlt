variable "cluster_name" {
  default = "gke-cluster"
  description = "- (Optional) Google Cluster name."
}

variable "deployment_name" {
  default = "cluster-infrastructure"
}

variable "deployment_environment" {
  default = "prod"
  description = "- (Optional) The domain name for cluster."
}

variable "google_bucket_name" {
  default = "rlt"
  description = "- (Optional) Google Region where cluster will be deployed."
}

variable "google_region" {
  default = "us-central1"
  description = "- (Optional) Google Region where cluster will be deployed."
}

variable "google_domain_name" {
  default = "turkmendevops.com"
  description = "- (Optional) The domain name for cluster."
}
variable "google_project_id" {
  default = "get-from-console"
  description = "- (Optional) Google Project ID for the cluster."
}

variable "cluster_node_count" {
  default = "3"
  description = "- (Optional) Count of clusters node"
}

variable "cluster_version" {
  default = "1.16"
  description = "- (Optional) The cluster version to deploy."
}

variable "google_credentials_json" {
  default = "service-account.json"
  description = "- (Optional) Google Service account Json file."
}
variable "sonarqube" {
type = "map"
  default = {
    admin_password            = "fuchicorp"
    username                  = "admin"
    sonarqube_auth_client_id  = "id"
    sonarqube_auth_secret     = "secret"
  }
}

