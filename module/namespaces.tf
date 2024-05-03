resource "time_sleep" "wait_2_seconds" {
  create_duration = "5s"
}
resource "vault_namespace" "child" {
  depends_on = [time_sleep.wait_2_seconds]
  namespace = length(var.parent_namespace) > 0 ? var.parent_namespace : null
  path      = var.child_namespace
}

resource "time_sleep" "wait_3_seconds" {
  depends_on = [vault_namespace.child]

  create_duration = "5s"
}

# depends_on = [time_sleep.wait_3_seconds]