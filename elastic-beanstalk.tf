# Create an application in Elastic Beanstalk. 
resource "aws_elastic_beanstalk_application" "ssfdata" {
  name        = "${var.app_name}"
  description = "ssfdata application"
}

# Provides an Elastic Beanstalk Configuration Template, which are associated with a 
# specific application and are used to deploy different versions of the application 
# with the same configuration settings.
resource "aws_elastic_beanstalk_configuration_template" "tf_template" {
  name                = "tf-test-template-config"
  application         = "${aws_elastic_beanstalk_application.ssfdata.name}"
  solution_stack_name = "${var.stack_name}"
}

# Create ELastic Beanstalk environment like: development, integration, or production.
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name          = "${var.dev_env}"
  application   = "${aws_elastic_beanstalk_application.ssfdata.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.tf_template.name}"
}

# Provides a S3 bucket resource.
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket}"
}

# Create a Beanstalk Application Version that can be deployed to a Beanstalk Environment.
resource "aws_elastic_beanstalk_application_version" "ssfdataV1" {
  name        = "ssfdata-v${var.version}"
  application = "${aws_elastic_beanstalk_application.ssfdata.id}"
  description = "application version created by terraform"
  bucket      = "${aws_s3_bucket.bucket.id}"
  key         = "ssfdata-v${var.version}.zip"
}
