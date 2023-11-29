#!/bin/bash
run_hooks () {
	if [[ ! -d "${1}" ]] ; then
		return
	fi
	echo "INFO: running hooks in ${1}"
	for f in "${1}/"*.sh; do
		echo "INFO: running script ${f}"
		source "${f}"
	done
	echo "INFO: done running hooks in ${1}"
}

run_hooks /etc/ai-cli/hooks/before-cmd.d
run_hooks $HOME/.local/hooks/before-cmd.d
echo "INFO: executing $@"
"$@"
exit_code=$?
echo "INFO: command exited with code $exit_code"
run_hooks /etc/ai-cli/hooks/after-cmd.d
run_hooks $HOME/.local/hooks/after-cmd.d
