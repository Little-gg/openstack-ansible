#!/usr/bin/env bash
# Copyright 2015, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## Shell Opts ----------------------------------------------------------------
set -e -u -v

# The default galera LB monitoring user has changed, we need to clean up the old "haproxy" user.
if ! grep '^galera_monitoring_user:' /etc/openstack_deploy/user_*.yml; then
  ansible "galera_all[0]" -m "mysql_user" -a "name=haproxy host='%' password='' priv='*.*:USAGE' state=absent"
  ansible "galera_all[0]" -m "mysql_user" -a "name=haproxy host='localhost' password='' priv='*.*:USAGE' state=absent"
fi
