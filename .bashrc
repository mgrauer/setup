
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias fixws="sed -i '' -e's/[[:space:]]*$//' $1"

test -f ~/.git-completion.bash && . $_
