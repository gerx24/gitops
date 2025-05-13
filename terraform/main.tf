module "argocd" {
  source           = "./modules/argocd"
  namespace        = "argocd"
  chart_version    = "5.21.0"
  environment      = "local"
}