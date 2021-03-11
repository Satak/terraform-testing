variable "tool" {
  type        = string
  default = "powershell"
    validation {
    condition     = contains(["powershell", "python"], var.tool)
    error_message = "Argument <tool> must be either <powershell> or <python>."
  }
}

variable "product_id" {
  type        = string
  description = "Input parameter for Python external tool to fetch data from db.json file"
  default = "1"
}

variable "usd_rate" {
  type        = string
  description = "Input parameter for Powershell external tool to fetch (API call) rate conversion between USD-EUR"
  default = "1"
}

locals {
  program        = {
    "python": "py"
    "powershell": "ps1"
  }
}

data "external" "my_data" {
  # dynamic program controlled by the tool variable
  program = [var.tool, "${path.module}/tool.${local.program[var.tool]}"]

  # hardcoded examples
  # program = ["python", "${path.module}/tool.py"]
  # program = ["powershell", "${path.module}/tool.ps1"]

  query = {
    input_param1 = "input #1 for script"
    input_param2 = "input #2 for script"
    product_id = var.product_id
    usd_rate = var.usd_rate
  }
}

output "data_from_external" {
  value = data.external.my_data.result.output
}
