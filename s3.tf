
resource "aws_s3_bucket" "june2020bucket" {
  bucket = "terraforms3bucket22062020" #NAming convention: "https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-s3-bucket-naming-requirements.html"
  acl    = "private"
  tags = {
    name        = "S3 bucket created via Terraform in N.virginia region"
    Environment = "${terraform.workspace}"
  }
}
#Error creating S3 bucket: InvalidBucketName: The specified bucket is not valid.	status code: 400, request id: 800CE7B1749FE8C5, host id: 5b55s5knoq29IM8+D3AQSl6PioGI4SWtpgfr41OSYCM0rHwSQ8dC5/y9mn36IYSTLNn0oK1bLMc=
#workaround: "should not put so many ..... in the bucket name "
