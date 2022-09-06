# Terraform Cloudfoundry Variant module

Setup for Prometheus + Variant on Cloudfoundry. 

## Features

- Deploys a Prometheus instance set up for Remote Write
- [Variant](https://github.com/philips-software/variant) sidecar for scrape target and rule discovery

## Example

```
module "variant" {
    source = "philips-labs/variant/cloudfoundry"
    version = "6.0.1"

    remote_write_config = file("remote_write.yaml")

    cf_org_name        = var.cf_org_name
    cf_space_id        = var.cf_space_id

    cf_functional_account = {
      api_endpoint = var.cf_api_url
      username     = var.cf_username
      password     = var.cf_password
    }
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.14.2 |
| <a name="requirement_hsdp"></a> [hsdp](#requirement\_hsdp) | >= 0.30.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.14.2 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | >= 0.30.10 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_network_policy.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_route.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_route.prometheus_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [random_password.password](https://registry.terraform.io/providers/random/latest/docs/resources/password) | resource |
| [cloudfoundry_domain.app_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_domain.apps_internal_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alertmanagers_endpoints"></a> [alertmanagers\_endpoints](#input\_alertmanagers\_endpoints) | List of endpoints of the alert managers | `list(string)` | `[]` | no |
| <a name="input_cf_functional_account"></a> [cf\_functional\_account](#input\_cf\_functional\_account) | Configuration for the CloudFoundry functional account. Required for variant. | <pre>object({<br>    api_endpoint = string<br>    username     = string<br>    password     = string<br>  })</pre> | n/a | yes |
| <a name="input_cf_org_name"></a> [cf\_org\_name](#input\_cf\_org\_name) | Cloudfoundry ORG name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | Cloudfoundry SPACE id to use for deploying all Thanos components. | `string` | n/a | yes |
| <a name="input_docker_password"></a> [docker\_password](#input\_docker\_password) | Docker registry password | `string` | `""` | no |
| <a name="input_docker_username"></a> [docker\_username](#input\_docker\_username) | Docker registry username | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Pass environment variable to the app | `map(any)` | `{}` | no |
| <a name="input_external_labels"></a> [external\_labels](#input\_external\_labels) | External labels to add | `map(any)` | <pre>{<br>  "cluster": "thanos",<br>  "replica": "0"<br>}</pre> | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| <a name="input_network_policies"></a> [network\_policies](#input\_network\_policies) | The container-to-container network policies to create with Prometheus as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| <a name="input_prometheus_disk_quota"></a> [prometheus\_disk\_quota](#input\_prometheus\_disk\_quota) | Prometheus disk quota | `number` | `5000` | no |
| <a name="input_prometheus_memory"></a> [prometheus\_memory](#input\_prometheus\_memory) | Prometheus memory | `number` | `1024` | no |
| <a name="input_prometheus_public_endpoints"></a> [prometheus\_public\_endpoints](#input\_prometheus\_public\_endpoints) | prometheus public endpoint | `bool` | `false` | no |
| <a name="input_remote_write_config"></a> [remote\_write\_config](#input\_remote\_write\_config) | The Promethues remote write section to inject | `string` | n/a | yes |
| <a name="input_spaces"></a> [spaces](#input\_spaces) | The list of CF space GUIDs to scrape. When provided variant will only consider apps in these spaces | `list(string)` | `[]` | no |
| <a name="input_tenants"></a> [tenants](#input\_tenants) | The list of tenants to scrape. When an app does not specify tenant then 'default' is used | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_variant_image"></a> [variant\_image](#input\_variant\_image) | Image to use for Thanos app. Use a v* tagged version to prevent automatic updates | `string` | `"philipslabs/cf-variant:v6.1.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postfix"></a> [postfix](#output\_postfix) | Cluster ID / Postfix of Prometheus deployment |
| <a name="output_prometheus_app_id"></a> [prometheus\_app\_id](#output\_prometheus\_app\_id) | App id for Promethues |
| <a name="output_prometheus_space_id"></a> [prometheus\_space\_id](#output\_prometheus\_space\_id) | Cloud foundry space ID of Prometheus |

<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel, or start a [discussion](https://github.com/philips-labs/terraform-cloudfoundry-variant/discussions)

# License

License is MIT

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.14.2 |
| <a name="requirement_hsdp"></a> [hsdp](#requirement\_hsdp) | >= 0.30.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.14.2 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | >= 0.30.10 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_network_policy.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/network_policy) | resource |
| [cloudfoundry_route.prometheus](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_route.prometheus_internal](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [random_password.password](https://registry.terraform.io/providers/random/latest/docs/resources/password) | resource |
| [cloudfoundry_domain.app_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_domain.apps_internal_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alertmanagers_endpoints"></a> [alertmanagers\_endpoints](#input\_alertmanagers\_endpoints) | List of endpoints of the alert managers | `list(string)` | `[]` | no |
| <a name="input_cf_functional_account"></a> [cf\_functional\_account](#input\_cf\_functional\_account) | Configuration for the CloudFoundry functional account. Required for variant. | <pre>object({<br>    api_endpoint = string<br>    username     = string<br>    password     = string<br>  })</pre> | n/a | yes |
| <a name="input_cf_org_name"></a> [cf\_org\_name](#input\_cf\_org\_name) | Cloudfoundry ORG name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | Cloudfoundry SPACE id to use for deploying all Thanos components. | `string` | n/a | yes |
| <a name="input_docker_password"></a> [docker\_password](#input\_docker\_password) | Docker registry password | `string` | `""` | no |
| <a name="input_docker_username"></a> [docker\_username](#input\_docker\_username) | Docker registry username | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Pass environment variable to the app | `map(any)` | `{}` | no |
| <a name="input_external_labels"></a> [external\_labels](#input\_external\_labels) | External labels to add | `map(any)` | <pre>{<br>  "cluster": "thanos",<br>  "replica": "0"<br>}</pre> | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| <a name="input_network_policies"></a> [network\_policies](#input\_network\_policies) | The container-to-container network policies to create with Prometheus as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| <a name="input_prometheus_disk_quota"></a> [prometheus\_disk\_quota](#input\_prometheus\_disk\_quota) | Prometheus disk quota | `number` | `5000` | no |
| <a name="input_prometheus_memory"></a> [prometheus\_memory](#input\_prometheus\_memory) | Prometheus memory | `number` | `1024` | no |
| <a name="input_prometheus_public_endpoints"></a> [prometheus\_public\_endpoints](#input\_prometheus\_public\_endpoints) | prometheus public endpoint | `bool` | `false` | no |
| <a name="input_remote_write_config"></a> [remote\_write\_config](#input\_remote\_write\_config) | The Promethues remote write section to inject | `string` | n/a | yes |
| <a name="input_spaces"></a> [spaces](#input\_spaces) | The list of CF space GUIDs to scrape. When provided variant will only consider apps in these spaces | `list(string)` | `[]` | no |
| <a name="input_tenants"></a> [tenants](#input\_tenants) | The list of tenants to scrape. When an app does not specify tenant then 'default' is used | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_variant_image"></a> [variant\_image](#input\_variant\_image) | Image to use for Thanos app. Use a v* tagged version to prevent automatic updates | `string` | `"philipslabs/cf-variant:v6.1.2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postfix"></a> [postfix](#output\_postfix) | Cluster ID / Postfix of Prometheus deployment |
| <a name="output_prometheus_app_id"></a> [prometheus\_app\_id](#output\_prometheus\_app\_id) | App id for Promethues |
| <a name="output_prometheus_space_id"></a> [prometheus\_space\_id](#output\_prometheus\_space\_id) | Cloud foundry space ID of Prometheus |
<!-- END_TF_DOCS -->