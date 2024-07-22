variable "do_token" {}
variable "my_key" {}
variable "access_key" {}
variable "secret_key" {}
variable "digitalocean_tag" {
  default = ["devops", "greshnov98_at_mail_ru"]
}
variable "droplet_name" {
  default = ["tf-08-1", "tf-08-2", "tf-08-3"]
}
variable "private_key_path" {
  sensitive = true
  default = "C:/Users/Михаил/.ssh/id_rsa"
}
variable "devs" {
  type = "list"
  default = ["mikhail_greshnov-db", "mikhail_greshnov-lk", "mikhail_greshnov-mg"]
}
variable "numbers" {
  default = ["1","2","3"]
}
