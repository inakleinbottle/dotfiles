
if hash exa 2>/dev/null; then
    alias ls=exa
    alias ll='exa -l'
    alias la='exa -la'
fi

if hash fdfind 2>/dev/null; then
    alias fd=fdfind
fi


alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
