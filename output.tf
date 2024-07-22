output "random_passwd" {
    description = "The password is:"
    sensitive = false
    value = [for pass in resource.random_password.password: nonsensitive(pass.result)]
}