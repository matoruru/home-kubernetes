{{- define "github-actions-runner-controller.valuesObject.base" -}}
controllerServiceAccount:
  namespace: arc-systems
  name: arc-gha-rs-controller
githubConfigSecret: pre-defined-secret
maxRunners: 3
minRunners: 1
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
