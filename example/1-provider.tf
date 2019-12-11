terraform {
  required_version = ">= 0.12.2"
}

provider "packet" {
  version    = ">= 2.2.1"
  auth_token = "${var.auth_token}"
}

module "kube_token_1" {
  source = "./modules/kube-token"
}
