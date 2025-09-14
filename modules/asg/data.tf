data "aws_key_pair" "tmp_key_pair" {
  key_name = var.temp_key_pair_name
}
