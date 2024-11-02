export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/fvm/default/bin:$PATH"
export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export ANDROID_HOME=~/Library/Android/sdk/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home/
# export ANDROID_HOME=/usr/local/share/android-commandlinetools/cmdline-tools/latest/bin
export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_NDK_HOME=/usr/local/share/android-commandlinetools/ndk-bundle
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/gradle@7/bin:$PATH"
export PATH=/users/derrik.fleming/Library/Python/3.9/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/derrik.fleming/.oh-my-zsh"
export EDITOR="/usr/local/bin/nvim"


ZSH_THEME="agnoster"
