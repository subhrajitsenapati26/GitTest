# Create a resource group
resource "azurerm_resource_group" "RGrp" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}