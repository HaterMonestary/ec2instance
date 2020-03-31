resource "aws_iam_role" "instance_role" {
  name               = "customer-instance-role"
  assume_role_policy = file("instance_assume.json")
  description        = "Instnace role for customer"
  path               = "/"
}

resource "aws_iam_policy" "customer" {
    name        = "customer-policy"
    path        = "/"
    description = "ncig IAM policy"
    policy      = data.template_file.instance_policy.rendered
    }

resource "aws_iam_policy_attachment" "customer-attachment" {
  name       = "customer-attachment"
  roles      = [aws_iam_role.instance_role.name]
  policy_arn = aws_iam_policy.customer.arn
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "awspolicy-attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}