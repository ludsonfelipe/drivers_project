resource "random_id" "random_number" {
  byte_length = 8
}
variable "project_id" { 
}
variable "project_region" {
  default = "us-central1"
}
// buckets

variable "bucket_cdc_relational" {
  default = "travels-bucket-312312312"
}
variable "bucket_drivers" {
  default = "drivers-bucket-4123123123"
}
variable "bucket_users" {
  default = "users-bucket-6436743743"
}
variable "bucket_travels" {
  default = "travels-bucket-535235324"
}

// topics
variable "topic_drivers" {
  default = "drivers_loc"
}
variable "topic_users" {
  default = "users_loc"
}
variable "topic_travel" {
  default = "travel_loc"
}
// cloud sql
variable "instance_cloud_sql" {
  default = "postgresdbs"
}
variable "database_name" {
  default = "travels_db"
}
variable "user_datastream_db" {
    default = "datastream"
}
variable "password_postgres" {
  default = "password"
}
// datastream
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