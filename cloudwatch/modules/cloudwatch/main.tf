resource "aws_cloudwatch_metric_alarm" "akeron_alarm" {
  alarm_name                = "akeronalarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  actions_enabled           = true
  alarm_actions             = ["arn:aws:swf:eu-central-1:863872515231:action/actions/AWS_EC2.InstanceId.Terminate/1.0"]

  dimensions = {
    InstanceId = var.ec2_id
  }
}



