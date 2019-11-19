# Helm Charts for Packet

Helm Charts for the Packet ecosystem.

Each chart will be in the relevant subdirectory. From the project root, you can install the desired Helm chart, identified by subdirectory name (i.e. `csi-packet`), for example, using:

```bash
helm install --debug --generate-name ./chart-name
```

Some may require a `Secret` object in order to authenticate with Packet's APIs.

## Setup

To use these charts with your Kubernetes cluster, you will need to [have Helm installed](https://v3.helm.sh/docs/intro/install/).

Some of these charts also require the existence of a `Secret` on your cluster in order to deploy and configure resources on your Packet account.

## Charts

The following charts are available:

### csi-packet

This configures the [Container Storage Interface implementation for Packet](https://github.com/packethost/csi-packet). To install run:

```
helm install --debug ./csi-packet
```

This chart requires a secret like the following:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: packet-cloud-config
  namespace: kube-system
stringData:
  cloud-sa.json: |
    {
     "apiKey": "your-api-key",
     "projectID": "your-project-id"
    }
```

before running `helm install`.

### packet-ccm

This configures the [Cloud Controller Manager implementation for Packet](https://github.com/packethost/ccm-packet). To install run:

```
helm install --debug ./packet-ccm
```

This chart requires a `Secret` like the following:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: packet-cloud-config
  namespace: kube-system
stringData:
  apiKey: "your-api-key"
  projectID: "your-project-id"
```

before running `helm install`.