{{- define "github-actions-runner-controller.valuesObject.base" -}}
controllerServiceAccount:
  namespace: arc-systems
  name: arc-gha-rs-controller
githubConfigSecret: pre-defined-secret
maxRunners: 3
minRunners: 1

# https://docs.github.com/en/actions/tutorials/actions-runner-controller/deploying-runner-scale-sets-with-actions-runner-controller#using-docker-in-docker-mode
containerMode:
  type: "dind"
{{- end -}}

{{- define "github-actions-runner-controller.valuesObject.dind.initContainer" -}}
initContainers:
- name: init-dind-externals
  image: ghcr.io/actions/actions-runner:latest
  command: ["cp", "-r", "/home/runner/externals/.", "/home/runner/tmpDir/"]
  volumeMounts:
  - name: dind-externals
    mountPath: /home/runner/tmpDir
{{- end -}}

{{- define "github-actions-runner-controller.valuesObject.dind.containers" -}}
- name: runner
  image: ghcr.io/actions/actions-runner:latest
  command: ["/home/runner/run.sh"]
  env:
    - name: DOCKER_HOST
      value: unix:///var/run/docker.sock
  volumeMounts:
    - name: work
      mountPath: /home/runner/_work
    - name: dind-sock
      mountPath: /var/run
- name: dind
  image: docker:dind
  args:
    - dockerd
    - --host=unix:///var/run/docker.sock
    - --group=$(DOCKER_GROUP_GID)
  env:
    - name: DOCKER_GROUP_GID
      value: "123"
  securityContext:
    privileged: true
  volumeMounts:
    - name: work
      mountPath: /home/runner/_work
    - name: dind-sock
      mountPath: /var/run
    - name: dind-externals
      mountPath: /home/runner/externals
{{- end -}}

{{- define "github-actions-runner-controller.valuesObject.dind.volumes" -}}
volumes:
  - name: work
    emptyDir: {}
  - name: dind-sock
    emptyDir: {}
  - name: dind-externals
    emptyDir: {}
{{- end -}}

{{- define "istio.ignoreDifferences" -}}
ignoreDifferences:
- group: admissionregistration.k8s.io
  kind: ValidatingWebhookConfiguration
  name: istio-validator-istio-system
  jsonPointers:
  - /webhooks/0/failurePolicy
- group: admissionregistration.k8s.io
  kind: ValidatingWebhookConfiguration
  name: istiod-default-validator
  jsonPointers:
  - /webhooks/0/failurePolicy
{{- end -}}
