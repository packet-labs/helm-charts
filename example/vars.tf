variable "auth_token" {
  description = "Your Packet API key"
}

variable "facility" {
  description = "Packet Facility"
  default     = "ewr1"
}

variable "project_id" {
  description = "Packet Project ID"
}

variable "plan_primary" {
  description = "K8s Primary Plan (Defaults to x86 - baremetal_0)"
  default     = "t1.small.x86"
}

variable "cluster_name" {
  description = "Name of your cluster. Alpha-numeric and hyphens only, please."
  default     = "packet-helm-charts"
}

variable "kubernetes_version" {
  description = "Version of Kubeadm"
  default     = "1.15.3-00"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key-- this is only used for control plane node spin-up locally; is not used if control_plane_node_count set to 0."
  default     = ""
}
