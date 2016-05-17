# Encoding: UTF-8
#
# Cookbook Name:: mac-os-base
# Recipe:: default
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
def enable!(app, path)
  # TODO: This should eventually take the form of applescript and
  # login_item resources in the mac_os_x cookbook.
  cmd = "osascript -e 'tell application \"System Events\" to make " \
        'new login item at end with properties ' \
        "{name: \"#{app}\", path: \"#{path}\", hidden: false}'"
  enabled_status = enabled?(app)
  execute "enable #{app}" do
    command cmd
    action :run
    only_if { !enabled_status }
  end
end

def enabled?(app)
  cmd = "osascript -e 'tell application \"System Events\" to get " \
        "the name of the login item \"#{app}\"'"
  !Mixlib::ShellOut.new(cmd).run_command.stdout.empty?
end

gem_file = 'accessibility_core-0.6.3.gem'
remote_path = 'https://github.com/RoboticCheese/accessibility_core/releases/' \
              "download/v0.6.3/#{gem_file}"
local_path = File.join(Chef::Config[:file_cache_path], gem_file)

include_recipe 'build-essential'

remote_file local_path do
  source remote_path
end

chef_gem 'accessibility_core' do
  clear_sources true
  source local_path
  compile_time false
end

execute 'killall Dock' do
  action :nothing
end

execute 'killall SystemUIServer' do
  action :nothing
end

%w(autohide magnification).each do |i|
  mac_os_x_userdefaults "com.apple.dock #{i}" do
    domain 'com.apple.dock'
    key i
    type 'boolean'
    value 'true'
    user Etc.getlogin
    notifies :run, 'execute[killall Dock]'
  end
end

mac_os_x_userdefaults 'com.apple.dock orientation' do
  domain 'com.apple.dock'
  key 'orientation'
  type 'string'
  value 'left'
  user Etc.getlogin
  notifies :run, 'execute[killall Dock]'
end

mac_os_x_userdefaults 'com.apple.dock largesize' do
  domain 'com.apple.dock'
  key 'largesize'
  type 'int'
  value 85
  user Etc.getlogin
  notifies :run, 'execute[killall Dock]'
end

mac_os_x_userdefaults 'com.apple.dock tilesize' do
  domain 'com.apple.dock'
  key 'tilesize'
  type 'int'
  value 35
  user Etc.getlogin
  notifies :run, 'execute[killall Dock]'
end

include_recipe 'mac_os_x::screensaver'

mac_os_x_userdefaults 'com.apple.dock bl-hot-corner' do
  domain 'com.apple.dock'
  key 'wvous-bl-corner'
  type 'int'
  value 5
  user Etc.getlogin
  notifies :run, 'execute[killall Dock]'
end

mac_os_x_userdefaults 'com.apple.dock bl-modifier' do
  domain 'com.apple.dock'
  key 'wvous-bl-modifier'
  type 'int'
  value 0
  user Etc.getlogin
  notifies :run, 'execute[killall Dock]'
end

mac_os_x_userdefaults 'com.apple.menuextra.battery ShowPercent' do
  domain 'com.apple.menuextra.battery'
  key 'ShowPercent'
  type 'string'
  value 'YES'
  user Etc.getlogin
  notifies :run, 'execute[killall SystemUIServer]'
end

include_recipe 'chef-dk'
include_recipe 'chef-client'
include_recipe 'chef-client::config'
include_recipe 'chef-client::delete_validation'
include_recipe 'homebrew'
include_recipe 'privacy_services_manager'

#################
# Homebrew Apps #
#################
homebrew_package 'ack'
homebrew_package 'autoconf'
homebrew_package 'lastpass-cli'
homebrew_package 'pass'
homebrew_package 'pkg-config'

homebrew_package 'gdbm'
homebrew_package 'sqlite'
homebrew_package 'python'
homebrew_package 'pyenv'
homebrew_package 'pyenv-virtualenv'
homebrew_package 'pyenv-virtualenvwrapper'
homebrew_package 'rbenv'
homebrew_package 'ruby'
homebrew_package 'tree'
homebrew_package 'tig'
homebrew_package 'todo-txt'
homebrew_package 'htop'

include_recipe 'python::pip'
python_pip 'virtualenv' do
  version '15.0.1'
end

python_pip 'virtualenvwrapper' do
  version '4.7.1'
end


##################
# App Store Apps #
##################
include_recipe 'app-store-alfred'
include_recipe 'mac-app-store'
include_recipe 'knock'
#include_recipe 'iwork'
include_recipe 'divvy'
#include_recipe 'fantastical'
include_recipe 'kindle'
#include_recipe 'airmail'
#include_recipe 'paw'

##############
# Other Apps #
##############
include_recipe 'chrome'
include_recipe 'dropbox'
include_recipe 'gimp'
include_recipe 'iterm2'
enable!('iTerm', '/Applications/iTerm.app')
include_recipe 'spotify'

##############
#    Misc    #
##############
include_recipe 'bash-it-more'
include_recipe 'dotfiles'

include_recipe 'base-mac-os::keymappings'
include_recipe 'base-mac-os::virtualbox'
