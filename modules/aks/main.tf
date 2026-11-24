
#############################
# AKS Cluster
#############################
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  #############################
  # Default Node Pool
  #############################
  default_node_pool {
    name            = "system"
    node_count      = var.system_node_count
    vm_size         = var.system_vm_size
    vnet_subnet_id  = var.aks_subnet_id
    os_disk_size_gb = var.os_disk_size_gb

    upgrade_settings {
      max_surge                     = "10%"
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
    }
  }

  #############################
  # Node Provisioning Profile (required in azurerm v5)
  #############################
  node_provisioning_profile {
    mode = var.node_provisioning_mode # "Auto" or "Manual"
  }

  #############################
  # Identity
  #############################
  identity {
    type = "SystemAssigned"
  }

  #############################
  # Networking
  #############################
  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    outbound_type  = "loadBalancer"
  }

  #############################
  # AAD RBAC (Optional)
  #############################
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.tenant_id != null && length(var.admin_group_object_ids) > 0 ? [1] : []
    content {
      azure_rbac_enabled     = true
      tenant_id              = var.tenant_id
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

  #############################
  # Monitoring (OMS Agent)
  #############################
  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id      = var.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = true
    }
  }

  #############################
  # Auto-upgrade
  #############################
  automatic_upgrade_channel = var.automatic_upgrade_channel

  tags = var.tags
}

#############################
# User Node Pool (optional)
#############################
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count = var.enable_user_node_pool ? 1 : 0

  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.user_vm_size
  node_count            = var.user_node_count
  vnet_subnet_id        = var.aks_subnet_id
  mode                  = "User"
  os_disk_size_gb       = var.os_disk_size_gb

  tags = var.tags
}
