{{/*
Frontend fullname.
*/}}
{{- define "frontend.fullname" -}}
{{- printf "%s-frontend" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frontend service name.
*/}}
{{- define "frontend.serviceName" -}}
{{- printf "%s-frontend-svc" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frontend ServiceAccount name.
*/}}
{{- define "frontend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "frontend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common labels for frontend resources.
*/}}
{{- define "frontend.labels" -}}
app: teams360-frontend
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: frontend
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels for frontend.
*/}}
{{- define "frontend.selectorLabels" -}}
app: teams360-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
API service name (for BACKEND_URL in frontend).
*/}}
{{- define "frontend.apiServiceName" -}}
{{- printf "%s-api-svc" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
