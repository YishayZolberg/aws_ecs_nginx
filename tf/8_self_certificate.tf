#Create tls certificate for alb https listner

resource "tls_private_key" "my_pk" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "my_ssc" {
  private_key_pem = tls_private_key.my_pk.private_key_pem
  subject {
    common_name  = "myNginx2.com"
    organization = "yzInc2"
  }
  validity_period_hours = 72
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.my_pk.private_key_pem
  certificate_body = tls_self_signed_cert.my_ssc.cert_pem
}