# Terraform Cloudfoundry Variant module

Setup for Prometheus + Variant on Cloudfoundry. 

## Features

- Deploys a Prometheus instance set up for Remote Write
- [Variant](https://github.com/philips-software/variant) sidecar for scrape target and rule discovery

## Example

```
module "variant" {
    source = "philips-labs/variant/cloudfoundry"
    version = "1.0.0"

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
<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel, or start a [discussion](https://github.com/philips-labs/terraform-cloudfoundry-variant/discussions)

# License

License is MIT
