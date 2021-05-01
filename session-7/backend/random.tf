resource "random_password" "password" {
    length = 20
    special = true
    override_special = "_%@"
}