{{- define "github-actions-runner-controller.valuesObject.base" -}}
controllerServiceAccount:
  namespace: arc-systems
  name: arc-gha-rs-controller
githubConfigSecret: pre-defined-secret
maxRunners: 3
minRunners: 1
{{- end -}}

{{- define "github-actions-runner-controller.valuesObject.dind" -}}
template:
  spec:
    initContainers:
      - name: init-dind-externals
        image: {{ .runnerImage }}
        imagePullPolicy: IfNotPresent
        command:
          ["cp", "-r", "/home/runner/externals/.", "/home/runner/tmpDir/"]
        volumeMounts:
          - name: dind-externals
            mountPath: /home/runner/tmpDir
    containers:
      - name: runner
        image: {{ .runnerImage }}
        imagePullPolicy: IfNotPresent
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
