output "cluster_name" {
  value = kind_cluster.main.name
}

output "cluster_endpoint" {
  value = kind_cluster.main.endpoint
}

output "nginx_access" {
  value = "http://localhost:30080"
}
