locals {
  additional_region_map = { for idx, region in var.additional_regions : idx => region }
}

resource "azurerm_container_registry" "main" {

  name                          = "cr${var.application_name}${var.environment_name}"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "Premium"
  zone_redundancy_enabled       = true
  admin_enabled                 = true
  public_network_access_enabled = true

  dynamic "georeplications" {
    for_each = local.additional_region_map
    content {
      location                = georeplications.value
      zone_redundancy_enabled = true
      tags                    = {}
    }
  }

}