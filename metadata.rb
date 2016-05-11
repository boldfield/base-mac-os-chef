# Encoding: UTF-8

name             'base-mac-os'
maintainer       'Brian Oldfield'
maintainer_email 'brian@oldfield.io'
license          'apache2'
description      'Installs/Configures base-mac-os'
long_description 'Installs/Configures base-mac-os'
version          '0.0.25'

depends          'bash-it-more'
depends          'dotfiles'
depends          'chrome'
depends          'python'
depends          'app-store-alfred'
depends          'build-essential', '~> 3.0'
depends          'chef-client', '~> 4.3'
depends          'mac_os_x', '~> 1.4'
depends          'chef-dk', '~> 3.0'
depends          'homebrew', '~> 2.0'
depends          'mac-app-store', '~> 1.2'
depends          'knock', '~> 0.1'
#depends          'iwork', '~> 0.1'
depends          'divvy', '~> 0.2'
#depends          'microsoft-remote-desktop', '~> 1.0'
#depends          'tweetbot', '~> 1.0'
#depends          'fantastical', '~> 0.1'
depends          'gimp', '~> 1.0'
depends          'iterm2', '~> 1.4'
depends          'kindle', '~> 0.1'
depends          'dropbox', '~> 0.1'
#depends          'box-sync', '~> 1.0'
#depends          'private-internet-access', '~> 0.1'
#depends          'plex-home-theater', '~> 1.0'
#depends          'skype-app', '~> 0.1'
depends          'spotify', '~> 1.0'
#depends          'steam', '~> 2.1'
#depends          'vlc', '~> 1.0'
#depends          'vmware-fusion', '~> 1.0'
#depends          'parallels', '~> 0.1'
#depends          'webhook', '~> 0.1'
#depends          'x2go-client', '~> 1.0'
#depends          'airmail', '~> 0.1'
#depends          'paw', '~> 0.1'

depends 'vagrant', '~> 0.5.0'
depends 'virtualbox', '~> 1.0.3'

supports         'mac_os_x'
