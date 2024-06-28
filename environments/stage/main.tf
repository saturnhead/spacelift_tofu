module "stage" {
  source = "../../spacelift"
  stacks = {
    stack1 = {
      branch                  = "main"
      description             = "Network Stack"
      project_root            = "tofu/network"
      repo                    = "spacelift_tofu"
      terraform_workflow_tool = "OPEN_TOFU"
      version                 = "1.7.0"
      labels                  = ["dev"]
    }

    stack2 = {
      branch                  = "main"
      description             = "EC2 Stack"
      project_root            = "tofu/ec2"
      repo                    = "spacelift_tofu"
      terraform_workflow_tool = "OPEN_TOFU"
      version                 = "1.7.0"
      labels                  = ["dev"]
    }
  }
  integrations = {
    integration1 = {
      integration_id = "01H79TE7EP3W7K4AMMV447J189"
      stack_name     = "stack1"
    }
    integration2 = {
      integration_id = "01H79TE7EP3W7K4AMMV447J189"
      stack_name     = "stack2"
    }
  }
  dependencies = {
    dependency1 = {
      stack_name       = "stack2"
      stack_depends_on = "stack1"
    }
  }
  dependency_references = {
    reference1 = {
      dependency_name = "dependency1"
      output_name     = "subnet_id"
      input_name      = "TF_VAR_subnet_id"
    }
  }
  policies = {
    policy1 = {
      policy_name = "tfsec"
    }
  }
  policy_attachments = {
    attachment1 = {
      policy_name = "policy1"
      stack_name  = "stack1"
    }
    attachment2 = {
      policy_name = "policy1"
      stack_name  = "stack2"
    }
  }
  contexts = {
    context1 = {
      description = "Network context"
      name        = "network context"
      before_init = ["wget -O tfsec https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec-linux-amd64", "chmod +x tfsec", "./tfsec -s --format=json . > tfsec.custom.spacelift.json"]
    }
    context2 = {
      description = "ec2 context"
      name        = "ec2 context"
      before_init = ["wget -O tfsec https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec-linux-amd64", "chmod +x tfsec", "./tfsec -s --format=json . > tfsec.custom.spacelift.json"]
    }
  }
  context_attachments = {
    attachment1 = {
      context_name = "context1"
      stack_name   = "stack1"
      priority     = 0
    }
    attachment2 = {
      context_name = "context2"
      stack_name   = "stack2"
      priority     = 0
    }
  }
  env_vars = {
    stack1_vpc_cidr = {
      context_name = "context1"
      name         = "TF_VAR_vpc_cidr"
      value        = "10.0.0.0/16"
    }
    stack1_subnet_cidr = {
      context_name = "context1"
      name         = "TF_VAR_subnet_cidr"
      value        = "10.0.1.0/24"
    }
    stack1_region = {
      context_name = "context1"
      name         = "TF_VAR_region"
      value        = "eu-west-1"
    }
    stack2_ami = {
      context_name = "context2"
      name         = "TF_VAR_ami"
      value        = "ami-06612c3e76b307724"
    }
    stack2_instance_type = {
      context_name = "context2"
      name         = "TF_VAR_instance_type"
      value        = "t2.micro"
    }
    stack2_region = {
      context_name = "context2"
      name         = "TF_VAR_region"
      value        = "eu-west-1"
    }
  }
}
