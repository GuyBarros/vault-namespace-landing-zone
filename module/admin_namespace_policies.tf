resource "vault_policy" "vault-per_namespace-admin" {
  name       = "${var.parent_namespace}_${var.child_namespace}_admin_policy"
  policy     = <<EOF
path "${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}/${vault_mount.kvv2.path}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}/${vault_mount.transit.path}/*" {
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
path "sys/mounts/${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}/${vault_mount.transit.path}" {
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
  depends_on = [vault_namespace.child]
}

# resource "vault_identity_group_policies" "others" {
#   policies = [
#     vault_policy.vault-per_namespace-admin.name
#   ]

#   exclusive = false

#   group_id = var.admin_group_id
# }
