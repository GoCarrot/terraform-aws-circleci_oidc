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

output "oidc_url" {
  description = "The OIDC URL. Useful in IAM assume role policies."
  value       = local.circleci_oidc_url
}

output "default_oidc_assume_role_policy" {
  description = "A default assume role policy that allows assumption from any CircleCI project."
  value       = data.aws_iam_policy_document.allow_circleci_oidc_assume.json
}
