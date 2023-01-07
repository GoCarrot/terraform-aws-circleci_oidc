# Copyright 2023 Teak.io, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4"
    }
  }
}

data "aws_default_tags" "tags" {}

locals {
  circleci_oidc_url = "oidc.circleci.com/org/${var.organization_id}"

  tags = { for key, value in var.tags : key => value if lookup(data.aws_default_tags.tags.tags, key, null) != value }
}

resource "aws_iam_openid_connect_provider" "circleci" {
  url = "https://${local.circleci_oidc_url}"

  client_id_list = [
    "${var.organization_id}",
  ]

  thumbprint_list = [for thumbprint in var.thumbprint : lower(replace(thumbrint, ":", ""))]

  tags = local.tags
}

data "aws_iam_policy_document" "allow_circleci_oidc_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.circleci.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.circleci_oidc_url}:aud"
      values   = [var.organization_id]
    }
  }
}
