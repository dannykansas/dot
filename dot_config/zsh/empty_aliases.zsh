# generic aliases
alias ll='ls -la'
alias lh='ls -lha'
alias ls-la='ls -la' # typo alias

# git aliases
alias gs='git status'
alias gp='git push'

# Terraform aliases
alias tfs='terraform show'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tf_state_snoop='echo "aws s3 cp s3://companyname-tfstate/path/to/state/terraform.tfstate - | grep terraform_version"'
