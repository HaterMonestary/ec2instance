resource "aws_security_group" "security_group" {
  name        = "customer-security-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = lookup(var.vpc_id, terraform.workspace)

  egress {
    # SQL (change to whatever ports you need)
    from_port   = 1433
    to_port     = 1434
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["10.255.41.166/32"]
  }

  ingress {
    # SQL ephemeral return (change to whatever ports you need)
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["10.255.41.166/32"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    # HTTP (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    # customer port (change to whatever ports you need)
    from_port   = 5800
    to_port     = 5800
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    # customer port (change to whatever ports you need)
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.16.0.0/16"]
  }

  ingress {
    # customer port (change to whatever ports you need)
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["10.255.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}
