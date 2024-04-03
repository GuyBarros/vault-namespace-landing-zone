
module "namespaces" {
  source           = "./module"
  for_each         = var.namespaces
  child_namespace  = each.key
  parent_namespace = each.value

}
