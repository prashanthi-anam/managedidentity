data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}
resource "azurerm_resource_group" "app_grp" {
    name = var.resourcegroup
    location = var.location
   
}



resource "azurerm_user_assigned_identity" "user_managed_identity" {

  name                = "user_managed_identity"
  resource_group_name = var.resourcegroup
  location            = var.location
  depends_on          = [azurerm_resource_group.app_grp]
}

resource "azurerm_user_assigned_identity" "system_assigned_identity" {

  name                = "system-assigned-identity"
  resource_group_name = var.resourcegroup
  location            = var.location
  depends_on          = [azurerm_resource_group.app_grp]
}

resource "azurerm_role_assignment" "user_managed_role_assignment" {

  scope                = azurerm_user_assigned_identity.user_managed_identity.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.user_managed_identity.principal_id
}

resource "azurerm_role_assignment" "system_assigned_role_assignment" {

  scope                = azurerm_user_assigned_identity.system_assigned_identity.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.system_assigned_identity.principal_id
}
