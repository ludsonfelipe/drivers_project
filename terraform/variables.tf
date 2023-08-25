resource "random_id" "random_number" {
  byte_length = 8
}
variable "project_id" { 
}
variable "project_region" {
  default = "us-central1"
}
variable "bucket_name" {
  default = "travels-bucket-${random_id.random_number.hex}"
}
variable "instance_cloud_sql" {
  default = "postgres_dbs"
}
variable "database_name" {
  default = "travels_db"
}
variable "user_datastream_db" {
    default = "datastream"
}
variable "datastream_name" {
  default = "cdc_travels"
}
variable "datastream_conn_db" {
  default = "datastream_db"
}
variable "datastream_conn_bucket" {
  default = "datastream_bucket"
}
variable "publication_name" {
  default = "publi"
}
variable "replication_name" {
  default = "repl"
}