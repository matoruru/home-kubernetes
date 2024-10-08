{{- define "github-actions-runner-controller.valuesObject.base" -}}
controllerServiceAccount:
  namespace: arc-systems
  name: arc-gha-rs-controller
githubConfigSecret: pre-defined-secret
maxRunners: 3
minRunners: 0
template:
  spec:
    initContainers:
    - name: init-dind-externals
      image: ghcr.io/actions/actions-runner:latest
      command: ["cp", "-r", "-v", "/home/runner/externals/.", "/home/runner/tmpDir/"]
      volumeMounts:
      - name: dind-externals
        mountPath: /home/runner/tmpDir
    - name: init-dind-rootless
      image: docker:dind-rootless
      command:
      - sh
      - -c
      - |
        set -x
        cp -a /etc/. /dind-etc/
        echo 'runner:x:1001:1001:runner:/home/runner:/bin/ash' >> /dind-etc/passwd
        echo 'runner:x:1001:' >> /dind-etc/group
        echo 'runner:100000:65536' >> /dind-etc/subgid
        echo 'runner:100000:65536' >>  /dind-etc/subuid
        chmod 755 /dind-etc;
        chmod u=rwx,g=rx+s,o=rx /dind-home
        chown 1001:1001 /dind-home
      securityContext:
        runAsUser: 0
      volumeMounts:
      - mountPath: /dind-etc
        name: dind-etc
      - mountPath: /dind-home
        name: dind-home
    containers:
    - name: runner
      image: {{ .runnerImage | default "ghcr.io/actions/actions-runner:latest" }}
      command: ["/home/runner/run.sh"]
      env:
      - name: DOCKER_HOST
        value: unix:///home/runner/var/run/docker.sock
      securityContext:
        privileged: true
        runAsUser: 1001
        runAsGroup: 1001
      volumeMounts:
      - name: work
        mountPath: /home/runner/_work
      - name: dind-sock
        mountPath: /home/runner/var/run
    - name: dind
      image: docker:dind-rootless
      args: ["dockerd", "--host=unix:///home/runner/var/run/docker.sock"]
      securityContext:
        privileged: true
        runAsUser: 1001
        runAsGroup: 1001
      volumeMounts:
      - name: work
        mountPath: /home/runner/_work
      - name: dind-sock
        mountPath: /home/runner/var/run
      - name: dind-externals
        mountPath: /home/runner/externals
      - name: dind-etc
        mountPath: /etc
      - name: dind-home
        mountPath: /home/runner
    volumes:
    - name: work
      emptyDir: {}
    - name: dind-externals
      emptyDir: {}
    - name: dind-sock
      emptyDir: {}
    - name: dind-etc
      emptyDir: {}
    - name: dind-home
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
