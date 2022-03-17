terraform {
  backend "azurerm"{
      resource_group_name = "terraformstaterg"
      storage_account_name = "terraformprodapac2"
      container_name = "cicd"
      key = "terraform.cicd"
      access_key = "kNNYwDdW3kZc5dFtayR0smsshT2/actpwqWvNkkdHWrfPiO0cf8jASSrpUF8FKaaLs2u2Nejcn6e0yvBVSk5Uw=="
  }
}


variable "subscription_id" {
  type        = string
  default     = "cb32ee6a-7ac6-4bbd-acfe-8178a388b2ec"
  description = "dev subscription id"

}
variable "client_id" {
  type        = string
  default     = "51a01385-937c-437e-9d9e-0deed6e0b059"
  description = "client id"


}

variable "client_secret" {
  type        = string
  default     = "7E57Q~dEcziGb6-~1XkqaNL9Yl1UazCdBw6Bf"
  description = "client secret"

}
variable "tenant_id" {
  type        = string
  default     = "a095b043-d4dd-4ff4-a16b-c7cb478b44b1"
  description = "tenant id"

}


provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

}
locals {
  setup_name = "practice_hyd"
}
resource "azurerm_resource_group" "testrglabel" {
  name = "testrgeastus"
  location = "East Us"
  tags = {
    "name" = "${local.setup_name}-rsg"
  }

  
}
resource "azurerm_app_service_plan" "testappplan" {
  name = "testappplan"
  location = azurerm_resource_group.testrglabel.location
  resource_group_name = azurerm_resource_group.testrglabel.name
  sku {
    tier = "standard"
    size = "S1"
  }
  depends_on = [
    azurerm_resource_group.testrglabel
  ]
  tags = {
    "name" = "${local.setup_name}-appplan"
  }
}

resource "azurerm_app_service" "testwebapp" {
  name = "testwebapp1004"
  location = azurerm_resource_group.testrglabel.location
  resource_group_name = azurerm_resource_group.testrglabel.name
  app_service_plan_id = azurerm_app_service_plan.testappplan.id
  tags = {
    "name" = "${local.setup_name}-webapp"
  }
  depends_on = [
    azurerm_app_service_plan.testappplan
  ]
  
}

