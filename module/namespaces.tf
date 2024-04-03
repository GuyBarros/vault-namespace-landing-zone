resource "vault_namespace" "child" {
  namespace = length(var.parent_namespace) > 0 ? var.parent_namespace : null
  path      = var.child_namespace
}
