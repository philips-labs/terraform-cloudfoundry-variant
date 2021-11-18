variable "cf_org_name" {
  description = "Cloudfoundry ORG name to use for reverse proxy"
  type        = string
}

variable "cf_space_id" {
  description = "Cloudfoundry SPACE id to use for deploying all Thanos components."
  type        = string
}

variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the space, hostname, etc. Prevents namespace clashes"
  default     = ""
}

variable "variant_image" {
  description = "Image to use for Thanos app. Use a v* tagged version to prevent automatic updates"
  default     = "philipslabs/cf-variant:v5.0.1"
  type        = string
}

variable "prometheus_public_endpoints" {
  description = "prometheus public endpoint"
  type        = bool
  default     = false
}

variable "environment" {
  type        = map(any)
  description = "Pass environment variable to the app"
  default     = {}
}

variable "docker_username" {
  type        = string
  description = "Docker registry username"
  default     = ""
}

variable "docker_password" {
  type        = string
  description = "Docker registry password"
  default     = ""
}

variable "prometheus_memory" {
  type        = number
  description = "Prometheus memory"
  default     = 1024
}

variable "prometheus_disk_quota" {
  type        = number
  description = "Prometheus disk quota"
  default     = 5000
}

variable "tenants" {
  type        = list(string)
  description = "The list of tenants to scrape. When an app does not specify tenant then 'default' is used"
  default     = ["default"]
}

variable "cf_functional_account" {
  type = object({
    api_endpoint = string
    username     = string
    password     = string
  })
  description = "Configuration for the CloudFoundry function account. Required for variant and if enable_cf_exporter is set to true"
  default = {
    api_endpoint = ""
    username     = ""
    password     = ""
  }
}

variable "alertmanagers_endpoints" {
  type        = list(string)
  description = "List of endpoints of the alert managers"
  default     = []
}

variable "network_policies" {
  description = "The container-to-container network policies to create with Grafana as the source app"
  type = list(object({
    destination_app = string
    protocol        = string
    port            = string
  }))
  default = []
}
