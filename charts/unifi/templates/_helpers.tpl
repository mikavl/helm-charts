{{/*
Expand the name of the chart.
*/}}
{{- define "unifi.unifi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "unifi.mongo.name" -}}
{{- printf "%s-%s" (include "unifi.unifi.name" .) "mongo" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "unifi.unifi.fullname" -}}
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

{{- define "unifi.mongo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-mongo
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-mongo
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-mongo
{{- end }}
{{- end }}
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
{{- define "unifi.unifi.labels" -}}
helm.sh/chart: {{ include "unifi.chart" . }}
{{ include "unifi.unifi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "unifi.mongo.labels" -}}
helm.sh/chart: {{ include "unifi.chart" . }}
{{ include "unifi.mongo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "unifi.unifi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "unifi.unifi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "unifi.mongo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "unifi.mongo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "unifi.unifi.serviceAccountName" -}}
{{- if .Values.unifi.serviceAccount.create }}
{{- default (include "unifi.unifi.fullname" .) .Values.unifi.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.unifi.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "unifi.mongo.serviceAccountName" -}}
{{- if .Values.mongo.serviceAccount.create }}
{{- default (include "unifi.mongo.fullname" .) .Values.mongo.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mongo.serviceAccount.name }}
{{- end }}
{{- end }}
