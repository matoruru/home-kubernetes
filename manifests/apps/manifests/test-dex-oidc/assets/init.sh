yarn init -y
yarn add @azure/keyvault-secrets @azure/identity
sed -i '/"main":/i\  "type": "module",' package.json
