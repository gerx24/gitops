variable "helm_repository" {
  type        = string
  description = "Helm repository to use for ArgoCD deployment."
  default     = "https://argoproj.github.io/argo-helm"
}

variable "helm_chart" {
  type        = string
  description = "Chart to deploy."
  default     = "argo-cd"
}

variable "chart_version" {
  type        = string
  description = "Version of the ingress-nginx helm chart."
  default     = null
}

variable "release_name" {
  type        = string
  description = "Name of the helm release."
  default     = "argocd"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy the ingress controller in."
  default     = "argocd"
}

variable "environment" {
  type        = string
  description = "Environment name."
}