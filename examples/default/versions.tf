terraform {
  required_providers {
    cloudfoundry = {
      source = "cloudfoundry-community/cloudfoundry"
    }
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.27.2"
    }
  }
}
