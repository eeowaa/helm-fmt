{{/* https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-subdomain-names */}}
{{- define "fmt.dns.subdomain" }}
  {{- lower .
    | list "[^a-z0-9.-]+" | include "rx.removeAll"
    | list "[^a-z0-9]+" | include "rx.trimPrefix"
    | trunc 253
    | list "[^a-z0-9]+" | include "rx.trimSuffix"
  }}
{{- end }}

{{/* https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-label-names */}}
{{- define "fmt.dns.label.rfc1123" }}
  {{- lower .
    | list "[^a-z0-9-]+" | include "rx.removeAll"
    | list "[^a-z0-9]+" | include "rx.trimPrefix"
    | trunc 63
    | list "[^a-z0-9]+" | include "rx.trimSuffix"
  }}
{{- end }}

{{/* https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#rfc-1035-label-names */}}
{{- define "fmt.dns.label.rfc1035" }}
  {{- lower .
    | list "[^a-z0-9-]+" | include "rx.removeAll"
    | list "[^a-z]+" | include "rx.trimPrefix"
    | trunc 63
    | list "[^a-z0-9]+" | include "rx.trimSuffix"
  }}
{{- end }}

{{/* Return a string that is safe to use for any Kubernetes resource name */}}
{{- define "fmt.k8s.name.safe" }}
  {{- include "fmt.dns.label.rfc1035" . }}
{{- end }}
