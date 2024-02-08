## Terraform GCP/GKE Kubernetes Cluster with Web Application

This Terraform project deploys a Kubernetes cluster with a web application on GCP with GKE.
*** NOTE: Load balancer need configuration post GKE cluster build

## GCP/GKE Configuration (main.tf)

### Placeholder Variables:

- `project`: The GCP project ID.
- `region`: The GCP region where the GKE cluster will be deployed.
- `name`: The name of the GKE cluster.
- `initial_node_count`: The initial number of nodes in the GKE cluster.
- `machine_type`: The machine type for the GKE nodes.
- `webapp_container_image`: The container image for the web application.

## How to Identify Placeholder Variables:

Look for lines in the Terraform code containing placeholder values enclosed in double asterisks (`**`). Replace these values with your actual configuration.

```hcl
provider "google" {
  credentials = file("**<path-to-your-service-account-key.json>**")
  project     = "**<your-project-id>**"
  region      = "**<desired-region>**"
}

resource "google_container_cluster" "primary" {
  name     = "**my-gke-cluster**"
  location = "**<desired-region>**"
  initial_node_count = **2**

  node_config {
    machine_type = "**n1-standard-2**"
  }
}

resource "google_container_node_pool" "webapp" {
  name       = "**webapp-pool**"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = **1**

  node_config {
    machine_type = "**n1-standard-2**"
    labels = {
      "app" = "**webapp**"
    }
  }
}

resource "kubernetes_deployment" "webapp" {
  metadata {
    name = "**webapp**"
  }

  spec {
    replicas = **1**

    selector {
      match_labels = {
        app = "**webapp**"
      }
    }

    template {
      metadata {
        labels = {
          app = "**webapp**"
        }
      }

      spec {
        container {
          image = "**<your-webapp-container-image>**"
          name  = "**webapp**"
        }
      }
    }
  }
}

resource "kubernetes_service" "webapp" {
  metadata {
    name = "**webapp**"
  }

  spec {
    selector = {
      app = "**webapp**"
    }

    port {
      protocol = "TCP"
      port     = **80**
      target_port = **80**
    }

    type = "LoadBalancer"
  }
}
