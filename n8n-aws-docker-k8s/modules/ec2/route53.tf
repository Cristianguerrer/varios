resource "aws_route53_record" "root" {
  zone_id = var.hosted_zone_id
  name    = var.record_name != "" ? var.record_name : var.domain
  type    = "A"

  alias {
    name                   = aws_lb.n8n.dns_name
    zone_id                = aws_lb.n8n.zone_id
    evaluate_target_health = true
  }
}
