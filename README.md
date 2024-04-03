# terraform-vault-namespace-langding zome
a quick TF code to showcase creating child admin groups that adds a parent group to its members of tenant specific policies

this terraform code creates namespace `landing zone` with default policies, secret engines and Auth methods

to run this TF code all that is needed is your Vault specific enviroment variables:

```bash
export VAULT_ADDR=https://<VAULT_ENTERPRISE_ADDR>
export VAULT_TOKEN=hunter2
```