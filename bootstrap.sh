#!/bin/bash
#
# This bootstrap script can be run immediately after completing the initial
# OS X walkthrough setup (setting a password, configuring iCloud, etc.). It
# will install Chef, register the Mac with Hosted Chef, and kick off a run to
# build a dev machine.

if [ `whoami` != "root" ]; then
  echo 'ERROR: This script must be run as the root user!'
  echo "       Try running it with 'sudo ${0}'"
  exit 1
fi

function status {
  for ((i = 1; i <= `echo -n $1 | wc -c` + 7; i++)); do
    DIV="${DIV}#"
  done
  echo $DIV
  echo "# ${1}... #"
  echo $DIV
}

function failure {
  echo 'ERROR! Bailing out!'
  exit 1
}

if [ $# != "3" ]
then
    echo "usage: $(basename $0) <org> <path to validator pem> <role>"
    exit 1
fi

CHEF_ORG=$1
CHEF_VALIDATOR=$2
CHEF_ROLE=$3
TMP_DIR=`mktemp -d`

status "Installing the Chef DK"
curl -L https://www.chef.io/chef/install.sh | bash -s -- -P chefdk || failure

status "Configuring the initial Chef run"
mkdir /etc/chef
cp ${CHEF_VALIDATOR} > ${TMP_DIR}/validation.pem
echo "chef_server_url 'https://api.chef.io/organizations/${CHEF_ORG}'" > ${TMP_DIR}/client.rb
echo "validation_client_name '${CHEF_ORG}-validator'" >> ${TMP_DIR}/client.rb
echo "client_key '${TMP_DIR}/validation.pem'" >> ${TMP_DIR}/client.rb
echo '{"run_list": ["role[${CHEF_ROLE}]"]}' > ${TMP_DIR}/dna.json

status "Running Chef"
chef-client -c ${TMP_DIR}/client.rb -j ${TMP_DIR}/dna.json || failure

rm -rf $TMP_DIR

exit 0






chef-client -s, --server SERVER \
  -k, --client-key KEY_FILE
  -c, --config CONFIG,
  -E, --environment ENVIRONMENT,
  -j, --json-attributes JSON,
  -N, --node-name NODE_NAME,


FLAGS chef-client is missing:

validation_client_name (does validation_key correspond at all?)


