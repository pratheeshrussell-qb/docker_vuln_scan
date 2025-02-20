{{- /* Trivy Markdown Report Template */ -}}
# Trivy Vulnerability Report

## Target: `{{ (index . 0).Target }}`
- **Type:** {{ (index . 0).Type }}
- **Generated At:** {{ now }}

{{- range . }}
### 🔍 Scan Results for `{{ .Type }}`
{{- if (eq (len .Vulnerabilities) 0) }}
✅ **No vulnerabilities found!**
{{- else }}
| **Package** | **Vulnerability ID** | **Severity** | **Installed Version** | **Fixed Version** | **Links** |
|------------|------------------|-------------|-----------------|---------------|--------|
{{- range .Vulnerabilities }}
| `{{ .PkgName }}` | [`{{ .VulnerabilityID }}`]({{ .PrimaryURL }}) | **{{ .Severity }}** | `{{ .InstalledVersion }}` | {{ if .FixedVersion }}`{{ .FixedVersion }}`{{ else }}❌ Not fixed{{ end }} |  
{{- range .References }}[link]({{ . }}) {{ end }} |
{{- end }}
{{- end }}
    
{{- if (eq (len .Misconfigurations) 0) }}
✅ **No misconfigurations found!**
{{- else }}
### ⚠️ Misconfigurations Found
| **Type** | **Misconf ID** | **Check** | **Severity** | **Message** |
|----------|--------------|--------|------------|----------|
{{- range .Misconfigurations }}
| `{{ .Type }}` | `{{ .ID }}` | `{{ .Title }}` | **{{ .Severity }}** | {{ .Message }}<br>[link]({{ .PrimaryURL }}) |
{{- end }}
{{- end }}
{{- end }}

---
⏳ **Scan completed at:** {{ now }}
