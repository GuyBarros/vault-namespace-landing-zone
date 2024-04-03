resource "vault_policy" "vault-namespace-admin" {
  name       = "namespace-admin"
  namespace  = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  policy     = file("${path.module}/policies/vault-namespace-admin.hcl")
  depends_on = [vault_namespace.child]
}
