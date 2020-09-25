# Inspired from old github repository
# Can't find project anymore
branch_color () {
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
            color=${c_green_blue}
    else
            color=${c_red_purple}
    fi
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    echo -ne "${color}($gitver)"
  else
     return 0
  fi
}

PS1="\$(branch_color)\${c_reset}$PS1"
