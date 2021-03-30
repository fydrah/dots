function awscreds() {
    # Looking for ~/.aws/creds*.sh files
    # Content of these files:
    # #!/bin/bash
    # export AWS_ACCESS_KEY_ID=$(pass xxx/xxx)
    # export AWS_SECRET_ACCESS_KEY=$(pass xxx/xxx)
    # export AWS_DEFAULT_REGION=us-east-1

    AWS_CREDS=$(ls -1 ~/.aws/creds*.sh | sed 's/.*creds-\(.*\)\.sh/\1/g' | fzf)
    [[ ! -z "$AWS_CREDS" ]] && source ~/.aws/creds-${AWS_CREDS}.sh && return 0
    echo "No credentials found" && return 1
}

function aws_ps1() {
    [[ -n "${AWS_ENV}" ]] && \
        echo -ne "${c_yellow}(aws:${AWS_ENV})${c_reset}"
}

PS1="\$(aws_ps1)$PS1"
