# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
# export TERM=xterm-kitty
export EDITOR=nvim
export PATH=$HOME/.local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export ZK_PATH=$HOME/Dropbox/notes
export PATH=/usr/bin:$PATH
# export DOCKER_HOST=unix:///run/user/1000/docker.sock
export COCKROACH_BINARY="$HOME/code/backend-services/cockroach.linux-amd64/cockroach"
. "$HOME/.cargo/env"
