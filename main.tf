
module "namespaces" {
  source           = "./module"
  for_each         = var.namespaces
  child_namespace  = each.key
  parent_namespace = each.value
  admin_group_id = vault_identity_group.namespaces_admin.id
  
}


resource "vault_identity_group" "namespaces_admin" {
  name     = "namespaces_admin"
  type     = "internal"
  # policies = ["default"]
member_entity_ids = [vault_identity_entity.tf_user.id]
  metadata = {
    version = "2"
  }

}

#--------------------------------
# Enable userpass auth method
#--------------------------------
resource "vault_auth_backend" "userpass" {
  type      = "userpass"
}
