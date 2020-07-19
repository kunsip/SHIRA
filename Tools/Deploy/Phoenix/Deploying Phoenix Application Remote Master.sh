# Version of the Application We're Deploying
# Script Version 0
VERSION="0.1.0"

# Directory

APP_ROOT_DIRECTORY='/home/username/app_dir'

# Runtime configuration
declare -i PORT=4000
SECRET_KEY_BASE=`mix phx.gen.secret`
DATABASE_URL=ecto://username:password@ip/database_name_prod

# Advanced configuration (don't change unless you know what you are doing)
MIX_ENV=prod
declare -i PORT_CONNECT_TO=80

### DO NOT EDIT BELOW SCRIPT UNLESS UPDATING MASTER SCRIPT ###
echo "Deploying Phoenix Application $VERSION to $APP_ROOT_DIR"
export $PORT && export $MIX_ENV && export $DATABASE_URL && export $SECRET_KEY_BASE

sudo iptables -t nat -I PREROUTING -p tcp --dport $PORT_TO_CONNECT -j REDIRECT --to-ports $PORT

cd $APP_ROOT_DIRECTORY

mix deps.get

cd assets && npm install

elixir --erl "-detached" -S mix phx.server

