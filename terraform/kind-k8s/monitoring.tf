# -------------------------------------------------------
# MONITORING STACK
# kube-prometheus-stack installs:
#   - Prometheus       (scrapes + stores metrics)
#   - Grafana          (dashboards)
#   - Node Exporter    (CPU, disk, memory metrics per node)
#   - Alertmanager     (handles alerts)
# -------------------------------------------------------

# Create a dedicated namespace for monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Deploy the full monitoring stack via Helm
resource "helm_release" "prometheus_stack" {
  name       = "prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.1.1"

  # Wait until all pods are healthy
  wait    = true
  timeout = 600

  # Custom values — configure alert rules + scrape targets
  values = [
    <<-YAML
    # Grafana settings
    grafana:
      adminPassword: "admin123"   # login: admin / admin123
      service:
        type: NodePort
        nodePort: 32000            # access at localhost:32000 (via port-forward)

    # Prometheus settings
    prometheus:
      prometheusSpec:
        # How often Prometheus scrapes metrics
        scrapeInterval: "30s"
        evaluationInterval: "30s"

    # Node Exporter — scrapes CPU, disk, memory from each node
    nodeExporter:
      enabled: true

    # Custom alert rules for high CPU and Disk usage
    additionalPrometheusRulesMap:
      custom-alerts:
        groups:
          - name: node-alerts
            rules:

              # Alert when CPU usage > 80% for 2 minutes
              - alert: HighCPUUsage
                expr: (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[2m])) by (instance)) * 100 > 80
                for: 2m
                labels:
                  severity: warning
                annotations:
                  summary: "High CPU usage on {{ $labels.instance }}"
                  description: "CPU usage is above 80% for 2 minutes"

              # Alert when disk usage > 85%
              - alert: HighDiskUsage
                expr: (1 - node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100 > 85
                for: 5m
                labels:
                  severity: critical
                annotations:
                  summary: "High disk usage on {{ $labels.instance }}"
                  description: "Disk usage is above 85%"
    YAML
  ]

  depends_on = [kubernetes_namespace.monitoring]
}
