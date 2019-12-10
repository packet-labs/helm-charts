#!/bin/bash

function install_docker() {
 echo "Installing Docker..." ; \
 apt-get update; \
 apt-get install -y docker.io && \
 cat << EOF > /etc/docker/daemon.json
 {
   "exec-opts": ["native.cgroupdriver=systemd"]
 }
EOF
}

function enable_docker() {
 systemctl enable docker ; \
 systemctl restart docker
}

function install_kube_tools {
 echo "Installing Kubeadm tools..." ; \
 swapoff -a  && \
 apt-get update && apt-get install -y apt-transport-https
 curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
 echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
 apt-get update
 apt-get install -y kubelet=${kube_version} kubeadm=${kube_version} kubectl=${kube_version}
}

function init_cluster {
  kubeadm init --token "${kube_token}" && \
  sysctl net.bridge.bridge-nf-call-iptables=1
}

function configure_network {
  kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
}

function apply_workloads {                                                                                                                                                                 
  echo "Applying workloads..." && \
        cd /root/kube && \
        kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f packet-config.yaml                                                                                               
} 

function packet_csi_config {
  mkdir /root/kube ; \
  cat << EOF > /root/kube/packet-config.yaml
apiVersion: v1
kind: Secret
metadata:
  name: packet-cloud-config
  namespace: kube-system
stringData:
  cloud-sa.json: |
    {
    "apiKey": "${packet_auth_token}",
    "projectID": "${packet_project_id}"
    }
EOF
}

function install_helm {
  /usr/bin/curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh && \
  chmod +x get_helm.sh && \
  ./get_helm.sh
}

install_docker && \
enable_docker && \
install_kube_tools && \
sleep 30 && \
install_helm && \
init_cluster && \
packet_csi_config && \
sleep 180 && \
configure_network && \
apply_workloads && \
kubectl --kubeconfig=/etc/kubernetes/admin.conf taint nodes --all node-role.kubernetes.io/master- 