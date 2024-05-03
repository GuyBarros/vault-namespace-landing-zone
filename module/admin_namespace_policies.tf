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

# List available secrets engines
path "sys/mounts/${length(var.parent_namespace) > 0 ? join("/", [var.parent_namespace, var.child_namespace]) : var.child_namespace}/${vault_mount.kvv2.path}" {
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


# Allow a token to wrap arbitrary values in a response-wrapping token
path "sys/wrapping/wrap" {
    capabilities = ["update"]
}

# Allow a token to look up the creation time and TTL of a given
# response-wrapping token
path "sys/wrapping/lookup" {
    capabilities = ["update"]
}

# Allow a token to unwrap a response-wrapping token. This is a convenience to
# avoid client token swapping since this is also part of the response wrapping
# policy.
path "sys/wrapping/unwrap" {
    capabilities = ["update"]
}

# Allow general purpose tools
path "sys/tools/hash" {
    capabilities = ["update"]
}
path "sys/tools/hash/*" {
    capabilities = ["update"]
}

# Allow checking the status of a Control Group request if the user has the
# accessor
path "sys/control-group/request" {
    capabilities = ["update"]
}

# Allow a token to make requests to the Authorization Endpoint for OIDC providers.
path "identity/oidc/provider/+/authorize" {
    capabilities = ["read", "update"]
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
