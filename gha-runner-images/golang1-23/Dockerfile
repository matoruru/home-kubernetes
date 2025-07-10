FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y golang-1.23 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
    mv ./kustomize /usr/local/bin/

WORKDIR /home/runner

USER runner
