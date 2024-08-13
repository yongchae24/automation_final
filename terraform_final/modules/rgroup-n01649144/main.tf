
resource "azurerm_resource_group" "n01649144-RG" {
  name     = "${var.humber_id}-RG"
  location = var.location
  tags = var.common_tags
}
