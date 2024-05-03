resource "vault_token_auth_backend_role" "test-role" {
  role_name              = "test-role"
  allowed_policies       = ["default"]
  orphan                 = false
  token_period           = "86400"
  renewable              = true
  token_explicit_max_ttl = "115200"
  path_suffix            = "path-suffix"
  allowed_entity_aliases = ["*"]
}

resource "vault_identity_entity" "tf_user" {
  name = "tf_user"
}

resource "vault_identity_entity_alias" "test" {
  name            = "tf_alias"
  mount_accessor  = data.vault_auth_backend.token.accessor
  canonical_id    = vault_identity_entity.tf_user.id
}

data "vault_auth_backend" "token" {
  path = "token"
}
