resource "aws_alb_target_group" "akeron_target_group" {
  name     = "akeron-target-group-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "akeron_tg_attachment" {
  target_group_arn = aws_alb_target_group.akeron_target_group.arn
  target_id        = var.public_ec2_id
  port             = 80
}

resource "aws_alb_target_group" "akeron_target_group_b" {
  name     = "akeron-target-group-b"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "akeron_tg_attachment_2" {
  target_group_arn = aws_alb_target_group.akeron_target_group_b.arn
  target_id        = var.private_ec2_id
  port             = 80
}

resource "aws_lb" "akeron_lb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_id, var.private_subnet_id]

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.akeron_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.akeron_target_group.arn
      }
      target_group {
        arn = aws_alb_target_group.akeron_target_group_b.arn
      }
    }
  }

}
