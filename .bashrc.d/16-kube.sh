# Copyright (c) 2017, Blendle
# https://github.com/blendle/kns
function kns(){
  local current
  local namespace
  local selected
  if [[ ! -x "$(which fzf 2>/dev/null)" ]]; then
    echo "please install: github.com/junegunn/fzf" >&2
    return 1
  fi
  current="$(kubectl config current-context)"
  currentregex="$(printf '%q' "$current" | sed 's/\(\.\|\/\)/\\\1/g')"
  namespace="$(kubectl config get-contexts "$current" | awk "/$currentregex/ {print \$5}")"
  if [[ -z "$namespace" ]]; then
    namespace="default"
  fi
  selected=$( (kubectl get namespaces -o name | sed "s-namespace/--"; echo $namespace ) | fzf -0 -1 --tac --prompt "$current> ")
  if [[ ! -z "$selected" ]]; then
    kubectl config set-context "$current" "--namespace=$selected"
    echo "Set to \"$selected\"."
  fi
}
