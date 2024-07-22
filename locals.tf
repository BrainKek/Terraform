locals {
  vps_record = digitalocean_droplet.vm_for_tf[*].ipv4_address
}
