#
# Author:: Benjamin Black (<b@b3k.us>) and Sean Cribbs (<sean@basho.com>)
# Cookbook Name:: cookbooks.riak
#
# Copyright (c) 2013 Basho Technologies, Inc.
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

default['cookbooks.riak']['package']['url'] = "http://s3.amazonaws.com/downloads.basho.com/cookbooks.riak"
default['cookbooks.riak']['package']['version']['major'] = "1"
default['cookbooks.riak']['package']['version']['minor'] = "3"
default['cookbooks.riak']['package']['version']['incremental'] = "0"
default['cookbooks.riak']['package']['version']['build'] = "1"
default['cookbooks.riak']['package']['config_dir'] = "/etc/cookbooks.riak"
default['cookbooks.riak']['package']['local_package'] = false

default['cookbooks.riak']['package']['checksum']['fedora']['17']                = "3c8dfccab67e74a886c6bfdcaa7a0f81bcb29b2c656a41b99d50b58d329cdde3"
default['cookbooks.riak']['package']['checksum']['local']                       = nil
