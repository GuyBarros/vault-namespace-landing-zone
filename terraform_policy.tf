resource "vault_policy" "policy_for_terraform" {
  name       = "policy_for_terraform"
  policy     = <<EOF
path "sys/namespaces/*" {
   capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/sys/namespaces/*" {
   capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/+/sys/namespaces/*" {
   capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/+/+/sys/namespaces/*" {
   capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}
  # List available secrets engines
path "sys/mounts/*" {
  capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/sys/mounts/*" {
  capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/+/sys/mounts/*" {
  capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}

path "+/+/+/sys/mounts/*" {
  capabilities = ["read", "create", "update", "delete", "sudo", "list"]
}
# Create and manage identities (entities, aliases, lookup, identity tokens, OIDC)
path "identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "+/identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "+/+/identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "+/+/+/identity/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}


# Manage ACL policies in the root level
path "sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "+/sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "+/+/sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "+/+/+/sys/policies/acl/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}


# Enable, disable, and read auth methods in the root level
path "sys/auth/*" {
  capabilities = ["read", "create", "update", "delete", "sudo"]
}

path "+/sys/auth/*" {
  capabilities = ["read", "create", "update", "delete", "sudo"]
}

path "+/+/sys/auth/*" {
  capabilities = ["read", "create", "update", "delete", "sudo"]
}

path "+/+/+/sys/auth/*" {
  capabilities = ["read", "create", "update", "delete", "sudo"]
}



# Configure Auth methods and CRUD Auth methods' roles in the root level
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Configure userpass, approle, etc.. auth methods
path "sys/mounts/auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/create"
{
  capabilities = ["update"]
}

  EOF

}