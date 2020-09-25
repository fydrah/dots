function os() {
    # Clear env
    for i in $(env|awk -F'=' '/OS_/ {print $1}'); do unset $i; done

    export OS_CLOUD=$(yq read ~/.config/openstack/clouds.yaml 'clouds' -j | jq -r '.|keys[]' | fzf --preview='yq read ~/.config/openstack/clouds.yaml "clouds.$(echo {}).custom"')

    # Check if there is a list of regions
    [[ -n $(yq read ~/.config/openstack/clouds.yaml "clouds.${OS_CLOUD}.custom.regions") ]] && \
      export OS_REGION_NAME=$(yq read ~/.config/openstack/clouds.yaml "clouds.${OS_CLOUD}.custom.regions" -j | jq -r '.[]' | fzf)

    # Check if there is a list of projects
    [[ -n $(yq read ~/.config/openstack/clouds.yaml "clouds.${OS_CLOUD}.custom.projects") ]] && \
      export OS_PROJECT_NAME=$(yq read ~/.config/openstack/clouds.yaml "clouds.${OS_CLOUD}.custom.projects" -j | jq -r '.[]' | fzf)

    TMP_USERNAME=$(yq read ~/.config/openstack/clouds.yaml "clouds.${OS_CLOUD}.auth.username")

    if [[ -z "$OS_CLOUD" || -z "$TMP_USERNAME" ]]
    then
        echo "No cloud choosen, or clouds.${OS_CLOUD}.auth.username is empty"
        return 1
    else
        export OS_PASSWORD=$(pass openstack/${OS_CLOUD}_${TMP_USERNAME})
        [[ -z "$OS_PASSWORD" ]] && unset OS_PASSWORD
        test -e ~/.openstack/common.sh && source ~/.openstack/common.sh
        test -e ~/.openstack/${OS_CLOUD}.sh && source ~/.openstack/${OS_CLOUD}.sh
    fi
    return 0
}

function os_ps1() {
    [[ -n "${OS_CLOUD}" ]] && echo -ne "${c_cyan}(${OS_REGION_NAME}$([[ -n ${OS_REGION_NAME} ]] && echo ':')${OS_CLOUD}$([[ -n ${OS_PROJECT_NAME} ]] && echo ':')${OS_PROJECT_NAME})${c_reset}"
}

PS1="\$(os_ps1)$PS1"

alias osl="openstack server list"
alias osc="openstack compute service list"
alias osn="openstack network agent list"
