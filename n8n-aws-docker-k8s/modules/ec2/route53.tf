data "aws_route53_zone" "this" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.record_name != "" ? var.record_name : data.aws_route53_zone.this.name
  type    = "A"

  alias {
    name                   = aws_lb.n8n.dns_name
    zone_id                = aws_lb.n8n.zone_id
    evaluate_target_health = true
  }
}
