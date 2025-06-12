output "hosted_zone_id" {
  value = aws_route53_zone.public.zone_id
}

output "certificate_arn" {
  value = aws_acm_certificate.ssl.arn
}
