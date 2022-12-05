{{/*
Expand the name of the chart.
*/}}
{{- define "mongo.name" -}}
{{- default "mongo" .Values.mongo.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongo.fullname" -}}
{{- if .Values.mongo.fullnameOverride }}
{{- .Values.mongo.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "mongo" .Values.mongo.nameOverride }}
{{- if contains $name "mongo" }}
{{- "mongo" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" "mongo" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongo.labels" -}}
helm.sh/chart: {{ include "mongo.chart" . }}
{{ include "mongo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongo.serviceAccountName" -}}
{{- if .Values.mongo.serviceAccount.create }}
{{- default (include "mongo.fullname" .) .Values.mongo.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mongo.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "unifi.name" -}}
{{- default .Chart.Name .Values.unifi.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "unifi.fullname" -}}
{{- if .Values.unifi.fullnameOverride }}
{{- .Values.unifi.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.unifi.nameOverride }}
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

{{/*
Selector labels
*/}}
{{- define "unifi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "unifi.name" . }}
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
