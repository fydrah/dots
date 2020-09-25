# .bashrc

# Source global definitions
if [ -f /etc/profile ]; then
  . /etc/profile
fi

# Custom scripts
test -d ~/.bashrc.d && for i in $(ls ~/.bashrc.d/);do . ~/.bashrc.d/$i ;done

# Custom bash completion
test -d ~/.bash_completion.d && for i in $(ls ~/.bash_completion.d/);do . ~/.bash_completion.d/$i ;done
