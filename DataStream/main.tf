resource "random_string" "test" {
  length = 4
  lower  = true
}


output "public_dns_name" {
  description = "Public DNS names of the load balancer for this project"
  value       = random_string.test.result
}