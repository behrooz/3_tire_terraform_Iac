variable name {
  type        = string  
}

variable acl {
    type        = string  
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"  
  tags = {
    Name        = "${var.name}"    
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = "${aws_s3_bucket.bucket.id}"
  acl    = "${var.acl}"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = "${aws_s3_bucket.bucket.id}"

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

output "website_endpoint" {
    value = "${aws_s3_bucket.bucket.website_endpoint}"
}