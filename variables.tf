variable "vpc_id" {
    type = map
    default = {
        prod="vpc-02e4bec8ea8b9a72e"
        nonprod="vpc-04c472742ccb3f1f3"
    }
}

variable "subnet_id" {
    type = map
    default = {
        prod="subnet-0bb6aa6830dbe6b4f"
        nonprod="subnet-072a16742fcdf0ec0"
    }
}

variable "profile" {
    type = map
    default = {
        prod="thomas-prod"
        nonprod="thomas-nonprod"
    }
}

variable "env" {
    type = map
    default = {
        prod="prod"
        nonprod="nonprod"
    }
}

variable "application_name" {
    type = string
    default = "our_application"
}

variable "client_name" {
    type = string
    default = "Tommo"
}
