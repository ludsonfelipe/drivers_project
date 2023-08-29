variable "project_id" { 
}
variable "project_region" {
  default = "us-central1"
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