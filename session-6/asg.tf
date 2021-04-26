resource "aws_autoscaling_group" "webserver-sg" {
  name                      = "${var.env}-webserver-asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = aws_launch_configuration.webserver_lc.name
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}

resource "aws_autoscaling_attachment" "webserver_attachment" {
  autoscaling_group_name = aws_autoscaling_group.webserver-sg.id
  alb_target_group_arn   = aws_lb_target_group.webserver_tg.arn
}
# Visual Studio Tricks
# Highlight and Command / = comment and uncomment
# Command F = Find, if you click enter it will go to the next word
# Highlight and Command d = Grab a group of words
# Command z = Rollback 
# Highlight and click TAB = moves a line to the right
# Highlight and click SHIFT + TAB = moves a line to the left