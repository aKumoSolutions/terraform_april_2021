resource "aws_autoscaling_group" "webserver-sg" {
  name                      = "${var.env}-webserver-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.webserver_lc.name
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids
}

# Visual Studio Tricks
# Highlight and Command / = comment and uncomment
# Command F = Find, if you click enter it will go to the next word
# Highlight and Command d = Grab a group of words
# Command z = Rollback 
# Highlight and click TAB = moves a line to the right
# Highlight and click SHIFT + TAB = moves a line to the left