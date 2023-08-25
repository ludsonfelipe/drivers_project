output "key" {
  value= google_sql_user.user.password
  sensitive = true
}