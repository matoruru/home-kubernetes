FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates curl gpg jq

# Install Azure CLI
#RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /home/runner

USER runner
