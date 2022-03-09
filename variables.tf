variable "INSTANCE_COUNT" {
	type = number
}
variable "change" {
	type = string
	default = "a"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  sensitive = true
}
resource "random_id" "id" {
	  byte_length = 8
}

