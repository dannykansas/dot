# make chezmoi less typo-prone
chez() {
    chezmoi "$@"
}

# Create and switch to a new branch
git_new() {
    git checkout -b "$1"
    git push -u origin "$1"
}

# Interactive rebase with specified number of commits
git_ri() {
    git rebase -i HEAD~"$1"
}

# Show git history for a specific file
git_history() {
    git log --follow -p -- "$1"
}

# Show most recently modified branches
git_recent_branches() {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
}

# Find commits by commit message
gfind() {
    git log --all --grep="$1"
}

### AWS
ECR_PROXY_ENDPOINT=`aws ecr get-authorization-token --output text --query 'authorizationData[].proxyEndpoint' --region us-west-2`
_ecr_login() {
	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $ECR_PROXY_ENDPOINT
}
