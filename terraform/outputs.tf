output "frontend_url" {
  value = "http://${aws_instance.ecommerce_instance.public_ip}:3000"
}