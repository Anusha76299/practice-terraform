/*terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "v1.11.1"
      address = "http://127.0.0.1:8200"
    }
  }
}*/
provider "vault"{
address = "http://127.0.0.1:8200"
}

