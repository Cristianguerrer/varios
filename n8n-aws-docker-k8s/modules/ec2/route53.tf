resource "aws_route53_zone" "public" {
  name = var.domain
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.public.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.n8n.dns_name
    zone_id                = aws_lb.n8n.zone_id
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.public.zone_id
#   name    = var.domain
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.n8n.public_ip]
# }