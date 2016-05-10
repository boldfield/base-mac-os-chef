# Encoding: UTF-8
#
# Cookbook Name:: mac-os-base
# Recipe:: virtualbox
#
# Copyright 2016 Brian Oldfield
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
include_recipe 'virtualbox'
include_recipe 'vagrant'

vagrant_plugin 'vagrant-omnibus'
vagrant_plugin 'vagrant-berkshelf'
vagrant_plugin 'vagrant-aws'
vagrant_plugin 'vagrant-digitalocean'
