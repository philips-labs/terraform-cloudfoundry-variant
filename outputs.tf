output "postfix" {
  description = "Cluster ID / Postfix of Prometheus deployment"
  value       = local.postfix
}

output "prometheus_space_id" {
  description = "Cloud foundry space ID of Prometheus"
  value       = var.cf_space_id
}

output "prometheus_app_id" {
  description = "App id for Promethues"
  value       = cloudfoundry_app.prometheus.id
}
