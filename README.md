# Helm Charts for Packet

Helm Charts for the Packet ecosystem

## Setup

To use these charts with your Kubernetes cluster, you will need to [have Helm installed](https://v3.helm.sh/docs/intro/install/).

Some of these charts also require the existence of a `Secret` on your cluster in order to deploy and configure resources on your Packet account:

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
