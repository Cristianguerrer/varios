resource "aws_route53_zone" "public" {
  name = var.domain
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.public.zone_id
  name    = var.record_name != "" ? var.record_name : aws_route53_zone.public.name
  type    = "A"

  alias {
    name                   = aws_lb.n8n.dns_name
    zone_id                = aws_lb.n8n.zone_id
    evaluate_target_health = true
  }
}
