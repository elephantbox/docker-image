# Bashrc features:
#   - environment in prompt (colorized in red when production)
#   - support for artisan code completion, if available
#   - ls helpers

WHERE=${APP_ENV^^}

if [[ "${APP_ENV}" == "production" ]]; then
  COLOR="\e[31m"
else
  COLOR="\e[32m"
fi

if [[ -x "/app/artisan" ]]; then
  _artisan () {
    COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
    COMMANDS=`php artisan --raw --no-ansi list | sed "s/[[:space:]].*//g"`
    COMPREPLY=(`compgen -W "$COMMANDS" -- "${COMP_WORDS[COMP_CWORD]}"`)
    return 0
  }

  complete -F _artisan art
  complete -F _artisan artisan
fi

alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'

export PS1="[\[$COLOR\]\$WHERE\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[36m\]\$APP_NAME\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[37m\]]\[\e[m\]\[\e[37m\]\\$\[\e[m\] "
