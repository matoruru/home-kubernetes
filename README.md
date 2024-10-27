<h1 align="center">Home-Kubernetes</h1>

[![App Status](https://argocd-statusbadge.matoru.ru/api/badge?name=argo-cd&revision=true&showAppName=true)](https://argocd-statusbadge.matoru.ru/applications/argo-cd)
[![App Status](https://argocd-statusbadge.matoru.ru/api/badge?name=github-actions-runner-controller&revision=true&showAppName=true)](https://argocd-statusbadge.matoru.ru/applications/github-actions-runner-controller)
[![App Status](https://argocd-statusbadge.matoru.ru/api/badge?name=external-secrets&revision=true&showAppName=true)](https://argocd-statusbadge.matoru.ru/applications/external-secrets)


## Introduction

Welcome to my Home-Kubernetes repository! My Home-Kubernetes cluster is a lightweight, flexible setup designed for middle-scale, personal projects. This setup can be easily adapted to suit various home automation needs, media servers, and other personal services.

Please refer to the [/manifests](/manifests) folder for its details.

## Architecture Diagram

All HTTPS traffics to the cluster are coming through Cloudflare Tunnels. For public contents like homepages it just directly allow to access to the web server. But for protected contents like any management clients such as Argo CD, it requires the user to be authenticated by Azure AD.

![](./_assets/home-kubernetes-diagram.drawio.svg)

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

### [External Secrets Operator (ESO)](https://external-secrets.io/latest/)

<img width="80px" src="./_assets/eso-logo-large.png">


Fetches Secrets from Azure Key vault and generates K8s Secret resources. Most of applications are relying on this. Can work with Workload Identity.

### [Istio Ingress Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)

<img width="80px" src="./_assets/istio-bluelogo-whitebackground-unframed.svg">

Quote from the official docs:

> Along with support for Kubernetes Ingress resources, Istio also allows you to configure ingress traffic using either an Istio Gateway or Kubernetes Gateway resource. A Gateway provides more extensive customization and flexibility than Ingress, and allows Istio features such as monitoring and route rules to be applied to traffic entering the cluster.

### [cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/)

<img width="80px" src="./_assets/cloudflared.png">

Exposes in-cluster services to the Internet through [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/).
