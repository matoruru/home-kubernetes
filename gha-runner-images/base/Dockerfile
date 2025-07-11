FROM ghcr.io/actions/actions-runner:2.326.0

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates curl gpg jq

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
    mv ./kustomize /usr/local/bin/

WORKDIR /home/runner

USER runner
