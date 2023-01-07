# CircleCI OIDC

This is a module to create a [CircleCI OIDC](https://circleci.com/docs/openid-connect-tokens/) provider in [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html),

## Installation

This is a complete example of a setup which creates a role that any CircleCI project in your organization may assume through the OIDC mechanism.

```hcl
provider "aws" {}

variable "circleci_organization_id" {
  description = "The UUID formatted Organization ID from CircleCI. This can be retrieved from Organization Settings in CircleCI."
  type        = string
}

module "circleci_oidc" {
  source = "GoCarrot/circleci_oidc/aws"

  organization_id = var.circleci_organization_id
}

resource "aws_iam_role" "circleci" {
  name               = "CircleCI"
  assume_role_policy = module.circleci_oidc.default_oidc_assume_role_policy
}
```
