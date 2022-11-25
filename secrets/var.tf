variable "example" {
  default = {
    username1 = "value1"
    password2va = "value2"
  }

  type = map(string)
}