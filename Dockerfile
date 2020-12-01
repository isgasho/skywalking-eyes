# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.14.3-alpine AS build

WORKDIR /src

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /bin/license-checker

FROM alpine:3 AS bin

COPY --from=build /bin/license-checker /bin/license-checker

WORKDIR /github/workspace/

ENTRYPOINT /bin/license-checker