module "variant" {
  source = "../../"

  remote_write_config = file("remote_write.yaml")

  cf_org_name = var.cf_org_name
  cf_space_id = data.cloudfoundry_space.space.id

  cf_functional_account = {
    api_endpoint = var.cf_api_url
    username     = var.cf_username
    password     = var.cf_password
  }
}
