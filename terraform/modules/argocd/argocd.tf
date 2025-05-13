locals {
  values = templatefile(
    "${path.module}/values.tftpl.yaml",
    {
      environment                = var.environment
    }
  )
}

# this release will install argo once and then should never attempt redeploying
# as argo will self-bootstrap with "app of apps"
resource "helm_release" "argocd" {
  name             = var.release_name
  repository       = var.helm_repository
  chart            = var.helm_chart
  version          = var.chart_version
  namespace        = var.namespace
  timeout          = 600
  values           = [local.values]

  lifecycle {
    ignore_changes = all
  }
}