{{/*
API fullname.
*/}}
{{- define "api.fullname" -}}
{{- printf "%s-api" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
API service name.
*/}}
{{- define "api.serviceName" -}}
{{- printf "%s-api-svc" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
API secret name.
*/}}
{{- define "api.secretName" -}}
{{- if .Values.existingSecret.name }}
{{- .Values.existingSecret.name }}
{{- else }}
{{- printf "%s-api-secret" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
API ServiceAccount name.
*/}}
{{- define "api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common labels for API resources.
*/}}
{{- define "api.labels" -}}
app: teams360-api
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: api
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels for API.
*/}}
{{- define "api.selectorLabels" -}}
app: teams360-api
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
PostgreSQL service name (for init container and DATABASE_URL).
*/}}
{{- define "api.postgresql.serviceName" -}}
{{- printf "%s-postgresql-svc" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL secret name.
*/}}
{{- define "api.postgresql.secretName" -}}
{{- if .Values.global.postgresql.existingSecret.name }}
{{- .Values.global.postgresql.existingSecret.name }}
{{- else }}
{{- printf "%s-postgres-secret" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
