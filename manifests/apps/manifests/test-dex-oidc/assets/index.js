import { SecretClient } from "@azure/keyvault-secrets";
import { DefaultAzureCredential } from "@azure/identity";
const credential = new DefaultAzureCredential();
const vaultUrl = 'https://home-k8s-keyvault.vault.azure.net/'
const client = new SecretClient(vaultUrl, credential);
async function main() {
  const secret = await client.getSecret('mytestsecret')
  console.log({ secret })
}
main()