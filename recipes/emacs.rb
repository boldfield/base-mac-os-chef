# Encoding: UTF-8
#
# Cookbook Name:: mac-os-base
# Recipe:: emacs
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
home_dir = "/Users/#{Etc.getlogin}"

homebrew_package 'emacs' do
  options '--with-ctags --with-dbus --with-glib --with-gnutls --with-imagemagick --with-mailutils'
end

bash "Decompress Spacemacs" do
  cwd home_dir
  user Etc.getlogin
  code <<-EOF
    [ -d .emacs.d ] && mv .emacs.d .emacs.d.$(date +'%s').bak
    unzip .emacs.d.zip
    mv spacemacs-master .emacs.d
    chown -R #{Etc.getlogin} .emacs.d
  EOF
  action :nothing
end

remote_file "#{home_dir}/.emacs.d.zip" do
  source node['spacemacs']['download_url']
  owner Etc.getlogin
  notifies :run, 'bash[Decompress Spacemacs]', :delayed
end
