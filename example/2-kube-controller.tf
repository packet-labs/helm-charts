module "controllers" {
  source = "./modules/controller_pool"

  kube_token               = "${module.kube_token_1.token}"
  kubernetes_version       = "${var.kubernetes_version}"
  plan_primary             = "${var.plan_primary}"
  facility                 = "${var.facility}"
  cluster_name             = "${var.cluster_name}"
  project_id               = "${var.project_id}"
  auth_token               = "${var.auth_token}"
  ssh_private_key_path     = "${var.ssh_private_key_path}"
}