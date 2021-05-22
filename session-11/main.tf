resource "aws_sqs_queue" "first_sqs" {
    name = "${terraform.workspace}-example-queue"
    #tags = let's assume it's added
}