{{/*
Expand the name of the chart.
*/}}
{{- define "unifi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "mongo.name" -}}
mongo
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "unifi.fullname" -}}
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

{{- define "mongo.fullname" -}}
mongo
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "unifi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "unifi.labels" -}}
helm.sh/chart: {{ include "unifi.chart" . }}
{{ include "unifi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "mongo.labels" -}}
helm.sh/chart: {{ include "unifi.chart" . }}
{{ include "mongo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.mongo.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "unifi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "unifi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "mongo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "unifi.serviceAccountName" -}}
{{- if .Values.unifi.serviceAccount.create }}
{{- default (include "unifi.fullname" .) .Values.unifi.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.unifi.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mongo.serviceAccountName" -}}
{{- if .Values.mongo.serviceAccount.create }}
{{- default (include "mongo.fullname" .) .Values.mongo.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mongo.serviceAccount.name }}
{{- end }}
{{- end }}
