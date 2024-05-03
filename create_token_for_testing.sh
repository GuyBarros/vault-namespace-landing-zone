vault token create -display-name=namespaces_admin -entity-alias=tf_alias -role=test-role



vault write sys/capabilities token=hvs.CAESIL57LGgLlwQ6MVw5bDDhCTUO6CTYjDfBtStKpHu9XaO7GikKImh2cy5nMjViSHduQ0ZubE1zUDc3bXBibmxUenAuOEJ5SnAQnLv8Ag paths="sys/namespaces/OrgA"


curl 'https://do-not-delete-ever-v2-public-vault-cf6a1d76.5773df81.z1.hashicorp.cloud:8200/v1/sys/internal/ui/namespaces' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H 'dnt: 1' \
  -H 'priority: u=1, i' \
  -H 'referer: https://do-not-delete-ever-v2-public-vault-cf6a1d76.5773df81.z1.hashicorp.cloud:8200/ui/vault/dashboard?namespace=admin' \
  -H 'sec-ch-ua: "Not-A.Brand";v="99", "Chromium";v="124"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' \
  -H 'x-vault-namespace: admin' \
  -H 'x-vault-token: hvs.CAESIL57LGgLlwQ6MVw5bDDhCTUO6CTYjDfBtStKpHu9XaO7GikKImh2cy5nMjViSHduQ0ZubE1zUDc3bXBibmxUenAuOEJ5SnAQnLv8Ag'


curl \
      -H 'x-vault-namespace: admin' \
      -H 'x-vault-token: hvs.CAESIL57LGgLlwQ6MVw5bDDhCTUO6CTYjDfBtStKpHu9XaO7GikKImh2cy5nMjViSHduQ0ZubE1zUDc3bXBibmxUenAuOEJ5SnAQnLv8Ag' \
     -X LIST \
    https://do-not-delete-ever-v2-public-vault-cf6a1d76.5773df81.z1.hashicorp.cloud:8200/v1/sys/namespaces/

