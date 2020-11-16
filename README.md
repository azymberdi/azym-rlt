# rlt_terraform_k8s_test
This repo holds the assets needed for our Terraform, Kubernetes, And Helm coding test


## Prerequisites.

Terraform >= 0.11.7

Kubernetes  >=  v1.14.8

Tiller >= v2.11.0

## Service Account

Creating the service account and attaching the json file will be necessary

## Tfvars.file.

Your .tfvars should be filled in accordingly


```
VARIABLES               ORIGINAL                EXAMPLE
cluster_name          = "CLUSTER_NAME"       # "rlt-cluster"
google_region         = "REGION"             # "us-central1" 
google_project_id     = "PROJECT_ID"         # "cool-project-2987"
cluster_node_count    = "NUMBER"             # "2"
cluster_version       = "CLUSTER_VERSION"    # "1.16"
google_bucket_name 		= "BUCKET_NAME "       # "rlt-test"
deployment_environment 	= "ENV"              # "dev"
google_credentials 	= "JSON_FILE"            #"service-account.json"
deployment_name			= "NAME"                 #"cluster-infrastructure"
```
