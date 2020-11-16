resource "helm_release" "rlt-test" {
  name  = "rlt-test"
  chart = "rlt-test"
}


locals {
  required_values = {
    ## Deployment endpoint for ingress
    deployment_endpoint = "${lower(var.deployment_endpoint)}"

    ## <deployment_name> for backend.tf and also release name
    deployment_name = "${lower(var.deployment_name)}"

    ## <env_vars> for global environment variables takes map()
    env_vars = "${trimspace(join("\n", data.template_file.env_vars.*.rendered))}"
  }

  ## When all requred values all deffined then also will incloude users values
  template_all_values = "${merge(local.required_values, var.template_custom_vars)}"

  timeout       = "${var.timeout}"
  recreate_pods = "${var.recreate_pods}"
}

## template_file.env_vars just converting to right values
data "template_file" "env_vars" {
  count    = "${length(keys(var.env_vars))}"
  template = "  $${key}: \"$${value}\""

  vars {
    key   = "${element(keys(var.env_vars), count.index)}"
    value = "${element(values(var.env_vars), count.index)}"
  }
}

## template_file.chart_values_template actual values.yaml file from charts
data "template_file" "chart_values_template" {
  count = "${var.remote_chart == "true" ? 0 : 1 }"
  template = "${file("charts/${var.deployment_path}/values.yaml")}"

  vars = "${local.template_all_values}"
}

## local_file.deployment_values will create the file output path.module/.cache/values.yaml
resource "local_file" "deployment_values" {
  count = "${var.remote_chart == "true" ? 0 : 1 }"
  content  = "${trimspace(data.template_file.chart_values_template.rendered)}"
  filename = "charts/.cache/${var.deployment_name}-values.yaml"
}

locals {
  trigger = "${var.trigger == "UUID" ? uuid() : var.trigger}"
}

## helm_release.helm_deployment is actual helm deployment
resource "helm_release" "helm_deployment" {
  count = "${var.remote_chart == "true" ? 0 : 1 }"
  name          = "${var.deployment_name}-${var.deployment_environment}"
  namespace     = "${var.deployment_environment}"
  chart         = "./charts/${var.deployment_path}"
  timeout       = "${local.timeout}"
  recreate_pods = "${local.recreate_pods}"
  version       = "${var.release_version}"

  values = [
    "${local_file.deployment_values.content}",
  ]
}

## helm_release.helm_deployment is actual helm deployment
resource "helm_release" "helm_remote_deployment" {
  count = "${var.remote_chart == "true" ? 1 : 0 }"
  name          = "${var.deployment_name}-${var.deployment_environment}"
  namespace     = "${var.deployment_environment}"
  chart         = "${var.deployment_path}"
  timeout       = "${local.timeout}"
  recreate_pods = "${local.recreate_pods}"
  version       = "${var.release_version}"
  values = [
    "${file("${var.values}")}"
  ]

}

###provider.tf
terraform {
  required_version = ">= 0.11.2"
}

#### variables.tf

## The name of the deployment
variable "deployment_name" {
  description = "The name of the deployment"
}

## The name of the environment
variable "deployment_environment" {
  description = "The name of the environment"
}

## Chart location or chart name
variable "deployment_path" {
  description = "Chart location or chart name <stable/example>"
}

## Endpoint for the application
variable "deployment_endpoint" {
  description = "Endpoint for the application"
}

variable "template_custom_vars" {
  type    = "map"
  default = {}
}

variable "env_vars" {
  type    = "map"
  default = {}
}

variable "trigger" {
  default = "UUID"
}

variable "timeout" {
  default = "400"
}

variable "recreate_pods" {
  default = false
}
 variable "release_version" {
   description = "(Required) Specify the exact chart version to install"
   default     = " 0.1.0"
  
 }


 variable "remote_chart" {
   default     = "false"
 }
 
variable "values" {
   default     = "values.yaml"
 }

 ###versions.tf

# required helm provider for this module 
provider "helm" { 
    version = "0.10.4"
}

# Required provider for local files 
provider "local" {
    version = "1.4.0"
}

# We are using 2.1.2 for helm deplpoy 
provider "template" {
    version  = "2.1.2"
}
 
