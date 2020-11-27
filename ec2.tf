provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "vkt" {
  ami                    = "ami-0083662ba17882949"
  instance_type          = var.instancetype
  key_name = "vkt"
  count = var.aws_vm_count
  subnet_id = "subnet-001e1c0e5ed78870c"
  vpc_security_group_ids = ["sg-04ceb4957e92b1de2"]
  user_data = <<-EOF
              #!/bin/bash
              yum install mlocate -y
              EOF
  tags = {
    Name = "vkt-ran${count.index + 1}"
    }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }
}
 resource "local_file" "inventory" {
    filename = "./host.ini"
    content = <<EOF
    [rancher-vms]
    vkt-ran1 ansible_ssh_host=${aws_instance.vkt[0].public_ip}
    vkt-ran2 ansible_ssh_host=${aws_instance.vkt[1].public_ip}
    vkt-ran3 ansible_ssh_host=${aws_instance.vkt[2].public_ip}

EOF
  }
