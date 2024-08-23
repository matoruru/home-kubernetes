# home-kubernetes
My home-Kubernetes cluster's manifests. Please refer to [/manifests](/manifests) folder for its details.

## Architecture Diagram

![](./_assets/home-kubernetes-diagram.drawio.png)

## Components

### [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)

<img width="80px" src="./_assets/COLOUR-Raspberry-Pi-Symbol-Registered-300x300.png">

8GB. The cluster is constructed with 3 Pis.
1 Pi is a control plane node. 2 Pis are worker nodes. I used Kubeadm for building a cluster on the Ubuntu Server 22.04 LTS.

### [Argo CD](https://argo-cd.readthedocs.io/en/stable/)

<img width="80px" src="./_assets/Argo-CD.svg">

Self-managed. Manages all applications with the beautiful UI.

### [GitHub Action Runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)

<img width="80px" src="./_assets/github-action-runner.png">

My GitHub Action Runners are self-hosted, run on my Raspberry Pis.
Runner's Dockerfiles are stored in [/gha-runner-images](./gha-runner-images/) folder.

### [akv2k8s](https://akv2k8s.io/)

<img width="80px" src="./_assets/akv2k8s-b749ec5f4bfd805a88626e0fd2b9ba82.png">


Fetches Secrets from Azure Key vault and generates K8s Secret resources. Most of applications are relying on this.

### [Ingress-NGINX Controller](https://github.com/kubernetes/ingress-nginx)

<img width="80px" src="./_assets/nginx-ingress-controller.png">


Ingress-NGINX Controller for Kubernetes. All incoming requests go through this component.

### [cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/)

<img width="80px" src="./_assets/cloudflared.png">

Allows me to expose any in-cluster services to the Internet through [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/).
