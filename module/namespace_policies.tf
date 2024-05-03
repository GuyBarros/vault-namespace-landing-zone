resource "vault_policy" "vault-namespace-admin" {
  
  name       = "namespace-admin"
  namespace  = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
  policy     = file("${path.module}/policies/vault-namespace-admin.hcl")
  depends_on = [vault_namespace.child,time_sleep.wait_3_seconds]
}

resource "vault_policy" "vault-namespace-independent" {
  
  name       = "${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}-admin"
  namespace  = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
policy     = <<EOF
path "${vault_mount.kvv2.path}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "${vault_mount.transit.path}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}


path "sys/namespaces/${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}" {
   capabilities = [ "read", "list"]
}

# List policies
path "sys/policies/acl" {
   capabilities = ["read", "list"]
}

# List available secrets engines
path "sys/mounts/${vault_mount.transit.path}" {
  capabilities = [ "read" ]
}

# List available secrets engines
path "sys/mounts/${vault_mount.kvv2.path}" {
  capabilities = [ "read" ]
}




# Allow a token to look up its resultant ACL from all policies. This is useful
# for UIs. It is an internal path because the format may change at any time
# based on how the internal ACL features and capabilities change.
path "sys/internal/ui/resultant-acl" {
    capabilities = ["read"]
}
path "+/sys/internal/ui/resultant-acl" {
     capabilities = ["read"]
 }
 path "+/+/sys/internal/ui/resultant-acl" {
     capabilities = ["read"]
 }

# Allow tokens to look up their own properties
path "auth/token/lookup-self" {
    capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

# Allow a token to look up its own capabilities on a path
path "sys/capabilities-self" {
    capabilities = ["update"]
}

# Allow a token to look up its own entity by id or name
path "identity/entity/id/{{identity.entity.id}}" {
  capabilities = ["read"]
}
path "identity/entity/name/{{identity.entity.name}}" {
  capabilities = ["read"]
}



  EOF
  depends_on = [vault_namespace.child,time_sleep.wait_3_seconds]
}


resource "vault_identity_group" "child_admin_group" {
  namespace  = length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace
 name       = "${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}-group"
  type     = "internal"
  policies = ["default", "${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}-admin"]

  metadata = {
    version = "2"
  }

   member_group_ids = [var.admin_group_id]

}