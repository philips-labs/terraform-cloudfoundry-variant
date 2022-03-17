terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = ">= 0.14.2"
    }
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.30.10"
    }
    random = {
      source  = "random"
      version = ">= 2.2.1"
    }
  }
}
