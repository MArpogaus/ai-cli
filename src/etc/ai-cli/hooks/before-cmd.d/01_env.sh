set -eu

source ~/.bashrc
FILE_PATH="/etc/ai-cli/hooks/env.yaml"
env_name=ai-cli
currenthash="$(mamba env export -n $env_name --no-builds | grep -v prefix | md5sum)"
targethash="$(cat $FILE_PATH | md5sum)"
echo "current hash $currenthash, target hash $targethash"

if [ "$currenthash" != "$targethash" ]; then
	mamba env remove -n $env_name
	mamba env create -y -n $env_name --file="$FILE_PATH" # recreate environment
	echo "recreated environment"
fi

mamba activate ai-cli
