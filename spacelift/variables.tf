variable "stacks" {
  description = "A map of stack configurations"
  type = map(object({
    branch                  = string
    description             = string
    project_root            = string
    repo                    = string
    terraform_workflow_tool = string
    version                 = string
    labels                  = list(string)
  }))
}

variable "integrations" {
  description = "A map of integration configurations"
  type = map(object({
    integration_id = string
    stack_name     = string
    read           = optional(bool, true)
    write          = optional(bool, true)
  }))
  default = {}
}

variable "dependencies" {
  description = "A map of dependency configurations"
  type = map(object({
    stack_name       = string
    stack_depends_on = string
  }))
  default = {}
}

variable "dependency_references" {
  description = "A map of dependency reference configurations"
  type = map(object({
    dependency_name = string
    output_name     = string
    input_name      = string
  }))
  default = {}
}

variable "policies" {
  description = "A map of policy configurations"
  type = map(object({
    policy_name = string
    type        = optional(string, "PLAN")
  }))
  default = {}
}

variable "policy_attachments" {
  description = "A map of policy attachment configurations"
  type = map(object({
    policy_name = string
    stack_name  = string
  }))
  default = {}
}


variable "contexts" {
  description = "A map of context configurations"
  type = map(object({
    description = string
    name        = string
    before_init = optional(list(string), [])
  }))
  default = {}
}

variable "env_vars" {
  description = "A map of environment variable configurations"
  type = map(object({
    context_name = string
    name         = string
    value        = string
    is_secret    = bool
  }))
  default = {}
}

variable "context_attachments" {
  description = "A map of context attachment configurations"
  type = map(object({
    context_name = string
    stack_name   = string
    priority     = optional(number, 0)
  }))
  default = {}
}
