{{/*
Expand the name of the chart.
*/}}
{{- define "teams360.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "teams360.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "teams360.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels applied to all resources.
Merges standard Kubernetes labels with org-specific global labels.
*/}}
{{- define "teams360.labels" -}}
helm.sh/chart: {{ include "teams360.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Resolve namespace - uses global override or Release namespace.
*/}}
{{- define "teams360.namespace" -}}
{{- default .Release.Namespace .Values.global.namespace }}
{{- end }}

{{/*
PostgreSQL service name for internal DNS.
*/}}
{{- define "teams360.postgresql.serviceName" -}}
{{- printf "%s-postgresql-svc" .Release.Name }}
{{- end }}

{{/*
Construct DATABASE_URL from PostgreSQL credentials.
*/}}
{{- define "teams360.databaseUrl" -}}
{{- $host := include "teams360.postgresql.serviceName" . -}}
{{- $user := .Values.postgresql.credentials.user -}}
{{- $password := .Values.postgresql.credentials.password -}}
{{- $db := .Values.postgresql.credentials.database -}}
{{- $sslmode := .Values.postgresql.credentials.sslmode -}}
{{- printf "postgres://%s:%s@%s:5432/%s?sslmode=%s" $user $password $host $db $sslmode -}}
{{- end }}
