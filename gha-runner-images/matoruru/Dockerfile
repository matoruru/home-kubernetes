FROM ghcr.io/actions-runner-controller/actions-runner-controller/actions-runner-dind:latest

COPY cleanup.sh /etc/arc/hooks/job-completed.d/cleanup.sh

USER root
RUN mkdir -p -m 755 /var/lib/docker /runner \
  && chown -R runner:runner /runner /var/lib/docker \
  && chmod -R +x /etc/arc/hooks

RUN apt-get update && apt-get upgrade -y && apt-get install jq

USER runner

WORKDIR /actions-runner

ARG RUNNER_CONTAINER_HOOKS_VERSION=0.6.1
ARG RUNNER_DIR=/actions-runner
RUN cd "${RUNNER_DIR}" \
  && curl -fLo runner-container-hooks.zip https://github.com/actions/runner-container-hooks/releases/download/v${RUNNER_CONTAINER_HOOKS_VERSION}/actions-runner-hooks-docker-${RUNNER_CONTAINER_HOOKS_VERSION}.zip \
  && unzip ./runner-container-hooks.zip -d ./runner-container-hooks-docker \
  && rm -f runner-container-hooks.zip
ENV ACTIONS_RUNNER_CONTAINER_HOOKS="${RUNNER_DIR}/runner-container-hooks-docker/index.js"

VOLUME [ "/runner", "/var/lib/docker" ]
