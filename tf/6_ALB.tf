#alb: get access from the world and load balance

resource "aws_lb" "my-alb" {
  name = "alb-to-ecs"
  internal = false
  load_balancer_type = "application"
  subnets = ["${aws_subnet.public_subnets-1.id}", "${aws_subnet.public_subnets-2.id}"]
  security_groups = [aws_security_group.elb_sg.id]
  
}
#print out the access URL
output "public_URL_ALB" {
  value = aws_lb.my-alb.dns_name
}

#target group for ecs nginx task
resource "aws_lb_target_group" "my-tg" {
  name        = "nginx-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
}

#listner, forward traffic to nginx target group
resource "aws_lb_listener" "alb-listner-https" {
  load_balancer_arn = aws_lb.my-alb.id
  port = 443
  protocol = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
  #associate with tls sels signed ca
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.cert.arn 

}

#listner to redirect the all traffic from http to https
resource "aws_lb_listener" "alb-listner-http" {
  load_balancer_arn = aws_lb.my-alb.id
  port = 80
  protocol = "HTTP"
  default_action {
    type             = "redirect"
    redirect {
      protocol        = "HTTPS"
      port            = "443"
      status_code     = "HTTP_301"
    }
  }
}