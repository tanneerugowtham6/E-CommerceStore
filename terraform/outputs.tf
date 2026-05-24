output "frontend_url" {
  value = "http://${aws_instance.ecommerce_instance.public_ip}:3000"
}

output "frontend_ip" {
  value = aws_instance.ecommerce_instance.public_ip
}