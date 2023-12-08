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

variable "organization_id" {
  type        = string
  description = "The UUID formatted Organization ID from CircleCI. This can be retrieved from Organization Settings in CircleCI."
}

variable "thumbprints" {
  type        = list(string)
  description = "The OIDC thumbprints used for the OIDC provider. You should probably use the default."
  default     = ["9E:99:A4:8A:99:60:B1:49:26:BB:7F:3B:02:E2:2D:A2:B0:AB:72:80"]
}

variable "tags" {
  type        = map(string)
  description = <<-EOT
  Tags to attach to created resources. Tags here will override default tags in the event of a conflict.
  EOT
  default     = {}
}