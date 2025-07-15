FROM matoruru/gha-runner-base:latest

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y golang-1.23 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/runner

USER runner
