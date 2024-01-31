provider "google" {
  credentials = file("<path-to-your-service-account-key.json>")
  project     = "<your-project-id>"
  region      = "<desired-region>"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "<desired-region>"
  initial_node_count = 2

  node_config {
    machine_type = "n1-standard-2"  # You can choose a different machine type if needed
  }
}

resource "google_container_node_pool" "webapp" {
  name       = "webapp-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1

  node_config {
    machine_type = "n1-standard-2"
    labels = {
      "app" = "webapp"
    }
  }
}

resource "kubernetes_deployment" "webapp" {
  metadata {
    name = "webapp"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image = "<your-webapp-container-image>"
          name  = "webapp"
        }
      }
    }
  }
}

resource "kubernetes_service" "webapp" {
  metadata {
    name = "webapp"
  }

  spec {
    selector = {
      app = "webapp"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
