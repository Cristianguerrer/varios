resource "aws_lb" "n8n" {
  name               = "${var.instance_name}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.n8n.id]

  tags = merge(var.tags, { Name = "${var.instance_name}-alb" })
}

resource "aws_lb_target_group" "n8n" {
  name     = "${var.instance_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.n8n.id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }

  tags = merge(var.tags, { Name = "${var.instance_name}-tg" })
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.n8n.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.n8n.arn
  }

  tags = merge(var.tags, { Name = "${var.instance_name}-listener" })
}

resource "aws_lb_target_group_attachment" "n8n" {
  target_group_arn = aws_lb_target_group.n8n.arn
  target_id        = aws_instance.n8n.id
  port             = 80
}