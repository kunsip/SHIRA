#!/bin/bash
#Pulled from /Tools/Deploy/Phoenix/Deploying\ Phoenix\ Application\ Master.sh
#Script Version 0

# Version of the Application We're Deploying
# Script Version 0
VERSION="0.1.0"

# Directory

export APP_ROOT_DIRECTORY='/home/pmierau/Core'

# Runtime configuration
export SENDGRID_API_KEY=<APIKEYHERE>
export PORT=4000
export DATABASE_URL=ecto://postgres:postgres@localhost/server_prod
# Advanced configuration (don't change unless you know what you are doing)
export MIX_ENV=prod
cd $APP_ROOT_DIRECTORY
export SECRET_KEY_BASE=<INSERT SECRET HERE>
### DO NOT EDIT BELOW SCRIPT UNLESS UPDATING MASTER SCRIPT ###
echo "Deploying Phoenix Application $VERSION in $APP_ROOT_DIRECTORY"
#Forwarding all external connections on port 80 to internal port 4000
#Can't figure out how to interpolate values. I keep getting iptable errors every time I try
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 4000
#Can't figure out how to fix erlexec: HOME must be set see https://elixirforum.com/t/running-compiled-elixir-app-as-a-service-systemd/18284
#However going to manually set it now till I figure out how to do it correctly
export HOME=/home/pmierau

cd $APP_ROOT_DIRECTORY
npm install #This is because right now all the node files are being transfered which means that macOSX bindings are being transfered, see issue #106
npm rebuild node-sass
mix phx.digest
mix ecto.create
mix ecto.migrate #Otherwise we get association errors and database inconsistencies
elixir --erl "-detached" -S mix phx.server
