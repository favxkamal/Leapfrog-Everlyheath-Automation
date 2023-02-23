# Transit Gateways

module "azure_transit_1" {
  source = "./modules/terraform-aviatrix-mc-transit"

  cloud                  = "azure"
  name                   = var.azure_transit_gateway_name
  region                 = var.azure_region1
  cidr                   = var.azure_cidr
  account                = var.azure_account_name
  insane_mode            = true
  instance_size          = var.azure_transit_gw_size
  local_as_number = var.azure_as_number
  enable_bgp_over_lan = true
  enable_transit_firenet = true
  bgp_lan_interfaces_count= var.interfacecount
}

module "azure_firenet_1" {
  source = "./modules/terraform-aviatrix-mc-firenet"

  transit_module         = module.azure_transit_1
  firewall_image         = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
  firewall_image_version = "9.1.0"
  instance_size          = var.azure_firewall_size
  egress_enabled         = true
}

# Spoke Gateway(HPE)

# module "azure_spoke_1_1" {
#   source = "./modules/terraform-aviatrix-mc-spoke"

#   cloud                  = "azure"
#   name                   = "azure-spoke-1-1"
#   cidr                   = "10.20.11.0/24"
#   region                 = "West US 2"
#   account                = var.azure_account_name
#   transit_gw             = module.azure_transit_1.transit_gateway.gw_name
#   insane_mode            = true
#   instance_size          = var.azure_hpe_spoke_gw_size
#   enable_max_performance = false
# }

# Spoke Gateway(non-HPE)

# module "azure_spoke_1_2" {
#   source = "./modules/terraform-aviatrix-mc-spoke"

#   cloud         = "azure"
#   name          = "azure-spoke-1-2"
#   cidr          = "10.20.12.0/24"
#   region        = "West US 2"
#   account       = var.azure_account_name
#   transit_gw    = module.azure_transit_1.transit_gateway.gw_name
#   insane_mode   = false
#   instance_size = var.azure_spoke_gw_size
# }