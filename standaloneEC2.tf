data "aws_caller_identity" "current" {}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.instance_role.name
}

data "template_file" "instance_policy" {
  template = file("instance_policy.json")
  vars = {
    account_id = data.aws_caller_identity.current.account_id
  }
}

resource "aws_ssm_parameter" "private_rsa_key" {
  name  = "ssh_keys-${upper(lookup(var.env, terraform.workspace))}"
  type  = "SecureString"
  value = tls_private_key.rsa_key.private_key_pem
}

resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "rsa_keypair" {
  key_name   = upper("ec2_ssh_keys")
  public_key = tls_private_key.rsa_key.public_key_openssh
}

resource "aws_instance" "instance_one" {
    depends_on              = [aws_key_pair.rsa_keypair]
    instance_type           = "t3.xlarge"
    ami                     = "ami-06c20c64" #windows
    iam_instance_profile    = aws_iam_instance_profile.instance_profile.name
    vpc_security_group_ids  = [aws_security_group.security_group.id]
    #user_data               = file("user_data.ps1")
    subnet_id               = lookup(var.subnet_id, terraform.workspace)
    key_name                = aws_key_pair.rsa_keypair.key_name
    tags = { 
        Name = "EC2-${upper(lookup(var.env, terraform.workspace))}"
        deployment = "Terraform"
        "client" = "${var.client_name}"
        "env" = lookup(var.env, terraform.workspace)
    }
    volume_tags = {
        Name = "MY_VOLUME"
    }

    root_block_device {
        delete_on_termination = true
        encrypted             = "true"
        volume_size           = "120"
        volume_type           = "gp2"
    }

    ebs_block_device {
        delete_on_termination = true
        device_name           = "/dev/sdb"
        encrypted             = "true"
        volume_size           = "500"
        volume_type           = "gp2"
    }

   
}


