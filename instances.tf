resource "aws_instance" "spoke1_instance" {
  ami                         = "ami-013d1df4bcea6ba95"
  instance_type               = "t2.nano"
  availability_zone           = "${var.primary_az}"
  subnet_id                   = "${aws_subnet.spoke1_subnet.id}"
  key_name                    = "Canada"
  associate_public_ip_address = "true"
  private_ip                  = "10.1.1.10"
  vpc_security_group_ids      = ["${aws_security_group.spoke1_security_group.id}"]

  tags {
    Name        = "Spoke-1"
  }
}

resource "aws_instance" "spoke2_instance" {
  ami                         = "ami-013d1df4bcea6ba95"
  instance_type               = "t2.nano"
  availability_zone           = "${var.primary_az}"
  subnet_id                   = "${aws_subnet.spoke2_subnet.id}"
  key_name                    = "Canada"
  associate_public_ip_address = "false"
  private_ip                  = "10.2.1.20"
  vpc_security_group_ids      = ["${aws_security_group.spoke2_security_group.id}"]

  tags {
    Name        = "Spoke-2"
  }
}