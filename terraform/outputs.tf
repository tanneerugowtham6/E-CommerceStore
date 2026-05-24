output "frontend_url" {
  value = "http://${aws_instance.ecommerce_instance.public_ip}"
}

output "frontend_ip" {
  value = aws_instance.ecommerce_instance.public_ip
}