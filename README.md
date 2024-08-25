<h1 align="center">Home-Kubernetes</h1>

## Introduction

Welcome to my Home-Kubernetes repository! My Home-Kubernetes cluster is a lightweight, flexible setup designed for middle-scale, personal projects. This setup can be easily adapted to suit various home automation needs, media servers, and other personal services.

Please refer to the [/manifests](/manifests) folder for its details.

## Architecture Diagram

![](./_assets/home-kubernetes-diagram.drawio.png)

## Components

### [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)

<img width="80px" src="./_assets/COLOUR-Raspberry-Pi-Symbol-Registered-300x300.png">

The cluster is composed of three *Raspberry Pi 4* devices, each with 8GB of RAM. One Pi serves as the control plane node, while the other two function as worker nodes. The cluster was set up using Kubeadm on Ubuntu Server 22.04 LTS.

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


The Ingress-NGINX Controller in your Kubernetes cluster directs all incoming web traffic to the correct services, following specific rules. Although it can manage SSL termination, I've chosen to handle that with Cloudflare instead. This decision simplifies the controller's role, allowing it to focus on routing traffic within the cluster without the redundant task of managing SSL certificates, which can help improve the overall efficiency and performance of my setup.

### [cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/)

<img width="80px" src="./_assets/cloudflared.png">

Allows me to expose any in-cluster services to the Internet through [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/).
