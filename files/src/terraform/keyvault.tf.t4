resource "azurerm_key_vault" "main" {
  name                          = "kv-${var.application_name}-${var.environment_name}"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  purge_protection_enabled      = false
}

resource "azurerm_role_assignment" "terraform_keyvault_access" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "github_token" {
  name         = "github-token"
  value        = var.github_token
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_keyvault_access]
}