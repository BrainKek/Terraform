resource "random_password" "password" {
  count = length(var.devs)
  length = "14"
  upper = true
  lower = true
  numeric = true
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "digitalocean_droplet" "vm_for_tf" {
  count = length(var.devs)
  name   = "${element(var.droplet_name, count.index)}"
  size   = "s-1vcpu-1gb"
  resize_disk = true
  image  = "ubuntu-22-04-x64"
  region = "nyc1"
  ssh_keys = [data.digitalocean_ssh_key.my_key.id, 
  data.digitalocean_ssh_key.rebrain_key.id]
  tags = var.digitalocean_tag
  provisioner "remote-exec" {
    inline = [ 
      "echo 'root:${random_password.password[count.index].result}' | sudo chpasswd"
     ]
  }
    connection {
      type = "ssh"
      user = "root"
      private_key = file(var.private_key_path)
      host = self.ipv4_address
  }
}

resource "aws_route53_record" "www" {
  count = length(var.devs)
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${element(var.devs, count.index)}.devops.rebrain.srwx.net"
  type    = "A" 
  ttl     = "30"
  records = local.vps_record
}

resource "local_file" "file" {
  content = templatefile("template.tftpl", {
    vmnumber = var.numbers,
    dns_name = aws_route53_record.www[*].name,
    ip_addr  = local.vps_record,
    pass = random_password.password[*].result
  })
  filename = "inventory.txt"
}
