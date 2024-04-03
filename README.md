# HashiCorp Vault Namespace Landing Zone

## DISCLAIMER: not for production use, showcase code only

This terraform code creates namespace `landing zone`s with default policies, secret engines and Auth methods

Please reffer to official [Namespaces documentation](https://developer.hashicorp.com/vault/docs/enterprise/namespaces)

to run this TF code all that is needed is your Vault specific enviroment variables:

```bash
export VAULT_ADDR=https://<VAULT_ENTERPRISE_ADDR>
export VAULT_TOKEN=hunter2
```
