#--------------------------------
# Enable userpass auth method
#--------------------------------
resource "vault_auth_backend" "userpass" {
  type      = "userpass"
  namespace = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
}

#--------------------------------
# Enable github auth method
#--------------------------------
resource "vault_auth_backend" "github" {
  namespace = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  type      = "github"
}


#--------------------------------
# Enable github k8s method
#--------------------------------
resource "vault_auth_backend" "k8s" {
  namespace = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  type      = "kubernetes"
}
