terraform {
  required_version = ">= 1.9"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 8.2"
    }
  }
}
