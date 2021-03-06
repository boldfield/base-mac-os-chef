My Dev Machine Cookbook
=======================
[![Cookbook Version](https://img.shields.io/cookbook/v/my-dev-machine.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/RoboticCheese/my-dev-machine-chef.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/RoboticCheese/my-dev-machine-chef.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/RoboticCheese/my-dev-machine-chef.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/my-dev-machine
[travis]: https://travis-ci.org/RoboticCheese/my-dev-machine-chef
[codeclimate]: https://codeclimate.com/github/RoboticCheese/my-dev-machine-chef
[coveralls]: https://coveralls.io/r/RoboticCheese/my-dev-machine-chef

A Chef cookbook to do as much configuring of a clean dev box as possible.

Requirements
============

This cookbook consumes a whole mess of other ones. Check `metadata.rb` for
details.

To Do
=====

I use many apps that either need cookbooks or have cookbooks that need updates
to work on OS X:

* Evernote
* MacVim
* Vagrant
* Atom
* Audacity
* CoconutBattery
* Colloquy
* Cyberduck
* Dash
* Epic Games Launcher (Unreal Engine)
* FaxFresh
* GarageBand
* GIFBrewery
* GitHub (app)
* Graphviz
* Growl
* Handbrake
* iMovie
* Induction (DB GUI)
* LibreOffice
* MarkdownPro
* MS Office
* MusicBrainz Picard
* Netgear USB Control Center
* OpenEmu
* Postgres.app
* Read Later
* Reggy
* Slack
* Sococo
* Stickies
* Textual
* Unity
* Vagrant Manager
* Vessel (http://awvessel.github.io)
* WiFi Explorer
* jexplorer

Some apps do have cookbooks I just need to verify:

* Alfred 2
* 1Password
* Chrome
* Adium
* Virtualbox
* Docker
* Firefox
* XCode

Usage
=====

Set up the `node['mac_app_store']['username']` and
`node['mac_app_store']['password']` attributes needed for the `mac-app-store`
cookbook and add the default recipe to your run_list.

* [Install OS X from a USB key](http://www.iclarified.com/35134/how-to-create-a-bootable-os-x-mavericks-usb-install-key)
* Walk through the initial setup
    * Apple ID
    * Location services
    * Wi-fi setup
* Enable any auto-imported email/Facebook/Twitter accounts
* Download and install the [Chef-DK](https://downloads.chef.io/chef-dk/)
* Drop off the validator key in `/etc/chef/validation.pem`
* Drop off a `/etc/chef/client.rb`:

```
chef_server_url 'https://api.chef.io/organizations/roboticcheese'
validation_client_name 'roboticcheese-validator'
use_policyfile true
policy_group 'dev'
policy_name 'dev-machine'
```

* Run Chef:

```
sudo chef-client
```

Recipes
=======

***default***

* Configures the Mac App Store
* Installs a bunch of App Store apps
    * Microsoft Remote Desktop
    * Tweetbot

Attributes
==========

***default***

Resources
=========

***my_dev_machine***

TODO: Describe each included resource.

Syntax:

    my_dev_machine 'my_resource' do
        attribute1 'value1'
        action :create
    end

Actions:

| Action  | Description  |
|---------|--------------|
| action1 | Do something |

Attributes:

| Attribute  | Default        | Description          |
|------------|----------------|----------------------|
| attribute1 | `'some_value'` | Do something         |
| action     | `:create`      | Action(s) to perform |

Providers
=========

TODO: Describe each included provider

***Chef::Provider::SomeProvider***

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <j@p4nt5.com>

Copyright 2015 Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
