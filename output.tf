output "cluster_name" {
  value = google_container_cluster.primary.name
}

# output "webapp_service_ip" {
#   value = kubernetes_service.webapp.load_balancer_ingress[0].ip
# }
