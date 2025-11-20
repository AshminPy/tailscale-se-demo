terraform {
  backend "gcs" {
    bucket = "tailscale-se-demo-tfstate-gcp"
    prefix = "gcp"
  }
}
