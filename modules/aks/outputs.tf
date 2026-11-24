
output "cluster_id" {
  description = "Resource ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config_raw" {
  description = "Raw kubeconfig for the cluster (admin)."
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "Kubernetes API server endpoint."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
  sensitive   = true
}

output "kubelet_identity" {
  description = "Kubelet managed identity details."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}

output "principal_id" {
  description = "Principal ID of the cluster's system-assigned identity."
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}
