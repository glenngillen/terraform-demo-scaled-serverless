variable "instance_count" {
	type = number
}
variable "change" {
	type = string
	default = "a"
}

resource "random_id" "id" {
	  byte_length = 8
}