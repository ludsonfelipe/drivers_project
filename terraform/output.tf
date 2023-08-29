output "key" {
  value= google_sql_user.user.password
  sensitive = true
}
output "public_host" {
  value = google_sql_database_instance.instance.public_ip_address
}