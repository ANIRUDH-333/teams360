{{/*
PostgreSQL fullname.
*/}}
{{- define "postgresql.fullname" -}}
{{- printf "%s-postgresql" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL service name.
*/}}
{{- define "postgresql.serviceName" -}}
{{- printf "%s-postgresql-svc" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL secret name.
*/}}
{{- define "postgresql.secretName" -}}
{{- if .Values.global.postgresql.existingSecret.name }}
{{- .Values.global.postgresql.existingSecret.name }}
{{- else }}
{{- printf "%s-postgres-secret" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels for PostgreSQL resources.
*/}}
{{- define "postgresql.labels" -}}
app: {{ include "postgresql.fullname" . }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: database
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}
