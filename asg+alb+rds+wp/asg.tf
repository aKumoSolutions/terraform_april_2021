resource "aws_autoscaling_group" "webserver_asg" {
  name                 = "${var.env}-webserve-asg"
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids
  target_group_arns    = [aws_lb_target_group.webserver_tg.arn]
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  force_delete         = true
  launch_configuration = aws_launch_configuration.webserver_lc.name
  health_check_type    = "EC2"
  tag {
    key                 = "Name"
    value               = "${var.env}-webserver"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_autoscaling_attachment" "webserver_tg_asg" {
  autoscaling_group_name = aws_autoscaling_group.webserver_asg.id
  alb_target_group_arn   = aws_lb_target_group.webserver_tg.arn
}

resource "aws_autoscaling_policy" "cpu_high" {
  name                   = "${var.env}-asg-cpu-high"
  autoscaling_group_name = aws_autoscaling_group.webserver_asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "1"
  cooldown               = "300"
}
# Scaling DOWN - CPU Low
resource "aws_autoscaling_policy" "cpu_low" {
  name                   = "${var.env}-asg-cpu-low"
  autoscaling_group_name = aws_autoscaling_group.webserver_asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "${var.env}-cpu-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.cpu_high.arn]
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.webserver_asg.name
  }
}
resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  alarm_name          = "${var.env}-cpu-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  actions_enabled     = true
  alarm_actions       = [aws_autoscaling_policy.cpu_low.arn]
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.webserver_asg.name
  }
}