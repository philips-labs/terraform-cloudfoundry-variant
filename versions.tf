terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = ">= 0.4.2"
    }
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.27.2"
    }
    random = {
      source  = "random"
      version = ">= 2.2.1"
    }
  }
}
