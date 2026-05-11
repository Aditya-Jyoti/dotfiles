#########
## ZSH ##
#########
#export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
#export UPDATE_ZSH_DAYS=13
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

export PROMPT_DIRTRIM=2

ZDOTDIR="$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/zsh_history"

COMPLETION_WAITING_DOTS="true" # Display red dots whilst waiting for completion.

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

prompt_dir() {
  # Shows only the name of the current directory
  prompt_segment blue $CURRENT_FG '%2~'
}


# Override theme: don't print user@machine
prompt_context() {}

source $HOME/.profile

#############
## Aliases ##
#############

# shutdown
alias poweroff="systemctl poweroff"
alias shutdown="systemctl poweroff"
alias restart="systemctl reboot"

# wifi
alias wConnect="iwctl station wlan0 connect"
alias wScan="iwctl station wlan0 scan"
alias wShow="iwctl station wlan0 show"
alias hostel="iwctl station wlan0 connect VITC-HOS2-4"
alias hotspot="iwctl station wlan0 connect ReverendToady"

# bluetooth
alias bList="bluetooth list"
alias bKnown="bluetooth devices"
alias overears="bluetoothctl connect EB:06:EF:65:42:AB"

# General
alias cls="clear"
alias mnt="sudo mount -t auto -o umask=0,uid=$(echo $USER),gid=$(echo $USER),rw"
alias umnt="sudo umount"

# Pacman
alias install="yay -S"
alias update="yay -Syu --removemake --noconfirm"
alias dump="yay -S --removemake"
alias yeet="yay -Rsn"
alias search="yay -Ss"
alias clean="yay -Qqdtt | yay -Rsn - ; yay -Sc"
alias query="yay -Si"

# node
#alias npm=pnpm
#alias npx=pnpm dlx

# docker
alias up="docker compose up --build -d"
alias down="docker compose down -v"

# nvidia
alias nvidia_run="__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias minecraft="__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia java -jar ~/Games/Minecraft/TLauncher.jar"
alias lunar="__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia java -jar /usr/bin/lunarclient"

###############
## Autostart ##
###############

# startx if we are on tty1
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

##################
## Key bindings ##
##################
# Get `showkey -a`

# Ctrl + Backspace to delete a word
bindkey '^H' backward-kill-word

#############
## Startup ##
#############

# Zoxide
eval "$(zoxide init zsh)"
alias cd="z"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/home/aditya/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

#######
# FZF #
#######

export FZF_DEFAULT_OPTS="--layout=reverse --border=bold --preview 'bat --color=always --style=numbers --line-range :500 {}' --preview-window 'right:50%'"

#######
# EXA #
#######

# alias ls="exa --grid --level=1 --git --icons"
# alias la="exa --tree --level=1 --git --icons --all"

### ENV

export EDITOR=nvim
export VISUAL=code

### LS

# alias ls="nnn -e"
# alias la="nnn -e -H"

alias ls="exa --tree --level=1 --icons --group-directories-first --icons"
alias la="exa --tree --level=1 --icons --group-directories-first --all --icons"

### keybind

# Define a custom widget named 'launch_alacritty'
function launch_alacritty() {
    alacritty & > /dev/null
}

zle -N launch_alacritty
bindkey '^T' launch_alacritty

export _JAVA_AWT_WM_NONREPARENTING=1
alias idea=intellij-idea-ultimate-edition

# bun completions
[ -s "/home/aditya/.bun/_bun" ] && source "/home/aditya/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#

# golang
#
export PATH="$PATH:$HOME/go/bin"

alias books="ssh -L 11111:localhost:11111 omrin"

eval "$(fzf --zsh)"
bindkey -v


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# wireguard
alias pinaca_down="sudo wg-quick down wg0adityajyoti"
alias pinaca_up="sudo wg-quick up wg0adityajyoti"

export ANDROID_HOME=$HOME/Android
export ANDROID_SDK_ROOT=$HOME/Android
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
