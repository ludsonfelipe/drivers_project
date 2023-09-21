resource "random_id" "random_number" {
  byte_length = 8
}

resource "google_storage_bucket" "bronze" {
  name  = "bronze-layer-${random_id.random_number.hex}"
  location = var.project_region
  force_destroy = true
}