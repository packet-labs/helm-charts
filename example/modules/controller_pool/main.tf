variable "kube_token" {}
variable "kubernetes_version" {}
variable "facility" {}
variable "cluster_name" {}
variable "project_id" {}
variable "auth_token" {}
variable "plan_primary" {}
variable "ssh_private_key_path" {}

data "template_file" "controller-primary" {
  template = "${file("${path.module}/controller-primary.tpl")}"

  vars = {
    kube_token               = "${var.kube_token}"
    packet_auth_token        = "${var.auth_token}"
    packet_project_id        = "${var.project_id}"
    kube_version             = "${var.kubernetes_version}"
  }
}

resource "packet_device" "k8s_primary" {
  hostname         = "${var.cluster_name}-controller"
  operating_system = "ubuntu_18_04"
  plan             = "${var.plan_primary}"
  facilities       = ["${var.facility}"]
  user_data        = "${data.template_file.controller-primary.rendered}"
  tags             = ["kubernetes", "controller-${var.cluster_name}"]

  billing_cycle = "hourly"
  project_id    = "${var.project_id}"

  provisioner "local-exec" {
    command = "echo ${self.network.0.address} > cluster_ip"
  }
}