
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

  metadata = {
    version = "2"
  }

  member_entity_ids = ["a935362c-bdfe-ccf6-62c9-896a0a8ad551"]

}

