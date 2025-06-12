output "n8n_server_public_ip" {
  description = "IP pública de la instancia n8n"
  value       = aws_instance.n8n_server.public_ip
}
