# Encoding: UTF-8
#
# Cookbook Name:: mac-os-base
# Recipe:: keymappings
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

include_recipe 'homebrew::cask'

KARABINER_APP = 'Karabiner'.freeze
KARABINER_PATH = "/Applications/#{KARABINER_APP}.app".freeze

KARABINER_AXNOTIFIER_APP = 'Karabiner_AXNotifier'.freeze
KARABINER_AXNOTIFIER_PATH = "/Applications/#{KARABINER_AXNOTIFIER_APP}.app".freeze

SEIL_APP = 'Seil'.freeze
SEIL_PATH = "/Applications/#{SEIL_APP}.app".freeze

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

def authorize_app!(app, path)
  include_recipe 'privacy_services_manager'
  privacy_services_manager "Grant Accessibility to '#{path}'" do
    service 'accessibility'
    applications ["/Applications/#{app}.app"]
    action :add
  end
end

homebrew_cask KARABINER_APP.downcase do
  options '--caskroom=/opt/homebrew-cask/Caskroom'
end
enable!(KARABINER_APP, KARABINER_PATH)
authorize_app!(KARABINER_APP, KARABINER_PATH)
authorize_app!(KARABINER_AXNOTIFIER_APP, KARABINER_AXNOTIFIER_PATH)

homebrew_cask SEIL_APP.downcase do
  options '--caskroom=/opt/homebrew-cask/Caskroom'
end
enable!(SEIL_APP, SEIL_PATH)
authorize_app!(SEIL_APP, SEIL_PATH)

SEIL_CLI = "#{SEIL_PATH}/Contents/Library/bin/seil"

bash 'configure seil' do
  code <<-EOF
    #{SEIL_CLI} set enable_capslock 1
    /bin/echo -n .
    #{SEIL_CLI} set keycode_capslock 59
    /bin/echo -n .
  EOF
end
