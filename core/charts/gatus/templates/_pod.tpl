{{- define "gatus-monitoring.pod" -}}
{{- if .Values.hostNetwork.enabled }}
hostNetwork: true
{{- end }}
{{- if .Values.image.pullSecrets }}
imagePullSecrets:
  {{- range .Values.image.pullSecrets }}
  - name: {{ . }}
  {{- end }}
{{- end }}
serviceAccountName: {{ include "names.serviceAccountName" . }}
automountServiceAccountToken: {{ .Values.serviceAccount.autoMount }}
securityContext:
  {{- toYaml .Values.podSecurityContext | nindent 2 }}
{{- if .Values.extraInitContainers }}
initContainers:
{{- toYaml .Values.extraInitContainers | nindent 2 }}
{{- end }}
containers:
{{- if .Values.sidecarContainers }}
  {{- range $name, $spec :=  .Values.sidecarContainers }}
  - name: {{ $name }}
    {{- if not $spec.securityContext }}
    securityContext:
      {{- toYaml $.Values.securityContext | nindent 6 }}
    {{- end }}
    {{- toYaml $spec | nindent 4 }}
  {{- end }}
{{- end }}
  - name: {{ .Chart.Name }}
    securityContext:
      {{- toYaml .Values.securityContext | nindent 6 }}
    {{- if .Values.image.sha }}
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}@sha256:{{ .Values.image.sha }}"
    {{- else }}
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
    {{- end }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    ports:
      - name: http
        containerPort: {{ .Values.service.targetPort }}
        protocol: TCP
    {{- if .Values.env }}
    env:
    {{- range $key, $value := .Values.env }}
    {{- if kindIs "map" $value }}
        - name: "{{ $key }}"
          valueFrom:
            {{- toYaml $value.valueFrom | nindent 12 }}
    {{- else }}
        - name: "{{ $key }}"
          value: "{{ $value }}"
    {{- end }}
    {{- end }}
    {{- end }}
    envFrom:
      - configMapRef:
          name: {{ include "names.fullname" . }}
      {{- if .Values.secrets }}
      - secretRef:
          name: {{ include "names.fullname" . }}
      {{- end }}
      {{- if .Values.envFrom }}
      {{- toYaml .Values.envFrom | nindent 6 }}
      {{- end }}
    {{- if .Values.readinessProbe.enabled }}
    readinessProbe:
      httpGet:
        path: /health
        port: http
    {{- end }}
    {{- if .Values.livenessProbe.enabled }}
    livenessProbe:
      httpGet:
        path: /health
        port: http
    {{- end }}
    resources:
      {{- toYaml .Values.resources | nindent 6 }}
    volumeMounts:
      - name: {{ include "names.fullname" . }}-config
        mountPath: /config
        readOnly: true
      {{- if .Values.persistence.enabled }}
      - name: {{ include "names.fullname" . }}-data
        mountPath: {{ .Values.persistence.mountPath }}
        {{- if .Values.persistence.subPath }}
        subPath: {{ .Values.persistence.subPath }}
        {{- end }}
      {{- end }}
    {{- range .Values.extraVolumeMounts }}
      - name: {{ .name }}
        mountPath: {{ .mountPath }}
        subPath: {{ .subPath | default "" }}
        readOnly: {{ .readOnly }}
    {{- end }}
volumes:
  - name: {{ include "names.fullname" . }}-config
    configMap:
      name: {{ include "names.fullname" . }}
  {{- if .Values.persistence.enabled }}
  - name: {{ include "names.fullname" . }}-data
    persistentVolumeClaim:
      claimName: {{ .Values.persistence.existingClaim | default (include "names.fullname" .) }}
  {{- end }}
{{- range .Values.extraVolumeMounts }}
  - name: {{ .name }}
    {{- if .existingClaim }}
    persistentVolumeClaim:
      claimName: {{ .existingClaim }}
    {{- else if .hostPath }}
    hostPath:
      path: {{ .hostPath }}
      type: {{ .hostPathType | default "" }}
    {{- else if .existingConfigMap }}
    configMap:
      name: {{ .existingConfigMap }}
    {{- else if .existingSecret }}
    secret:
      secretName: {{ .existingSecret }}
    {{- else }}
    emptyDir: {}
    {{- end }}
{{- end }}
{{- with .Values.nodeSelector }}
nodeSelector:
{{ toYaml . | indent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
{{ toYaml . | indent 2 }}
{{- end }}
{{- end }}
