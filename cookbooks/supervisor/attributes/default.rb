#
# Cookbook Name:: cookbooks.supervisor
# Attribute File:: default
#
# Copyright 2011, Opscode, Inc.
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
#

default['cookbooks.supervisor']['inet_port'] = nil
default['cookbooks.supervisor']['inet_username'] = nil
default['cookbooks.supervisor']['inet_password'] = nil
default['cookbooks.supervisor']['dir'] = '/etc/cookbooks.supervisor.d'
default['cookbooks.supervisor']['log_dir'] = '/var/log/cookbooks.supervisor'
default['cookbooks.supervisor']['logfile_maxbytes'] = '50MB'
default['cookbooks.supervisor']['logfile_backups'] = 10
default['cookbooks.supervisor']['loglevel'] = 'info'
default['cookbooks.supervisor']['minfds'] = 1024
default['cookbooks.supervisor']['minprocs'] = 200
