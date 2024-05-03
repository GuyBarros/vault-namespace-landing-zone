
resource "vault_mount" "kvv2" {
  namespace = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  path      = join("_", [var.child_namespace, "secret"])
  type      = "kv"
  options = {
    version = "2"
  }
  depends_on = [vault_namespace.child,time_sleep.wait_3_seconds]
}


resource "vault_mount" "transit" {
  namespace   = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  path        = join("_", [var.child_namespace, "transit"])
  type        = "transit"
  description = "This is an example transit secret engine mount"
  depends_on  = [vault_namespace.child,time_sleep.wait_3_seconds]
}
