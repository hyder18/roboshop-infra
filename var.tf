variable "instances" {
  default = {
    frontend = {
    name = "frontend"
    type = "t3.micro"
      password = " "
  }
    mongdb = {
      name = "mongodb"
      type = "t3.micro"
      password = " "
    }
    catalogue = {
      name = "catalogue"
      type = "t3.micro"
      password = " "
    }
    mysql = {
      name = "mysql"
      type = "t3.micro"
      password = "RoboShop@1"
    }
    cart = {
      name = "cart"
      type = "t3.micro"
      password = " "
    }
    user = {
      name = "user"
      type = "t3.micro"
      password = " "
    }
    shipping= {
      name = "shipping"
      type = "t3.micro"
      password = "RoboShop@1"
    }
    payment = {
      name = "payment"
      type = "t3.micro"
      password = "roboshop123"
    }
    rabbitmq = {
      name = "rabbitmq"
      type = "t3.micro"
      password = "roboshop123"
    }
    dispatch = {
      name = "dispatch"
      type = "t3.micro"
      password = "roboshop123"
    }
    redis = {
      name = "redis"
      type = "t3.micro"
      password = " "
    }
  }
}