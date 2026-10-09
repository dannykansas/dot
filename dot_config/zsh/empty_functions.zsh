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

# Show files changed on this branch vs a base (default origin/main).
# Three dots compare against where the branch split off, so this matches the PR's
# "Files changed" tab. Two dots (main..HEAD) also show everything merged to main
# since, which is a lot of noise in a busy repo.
git-diff-filenames() {
    git diff --name-status "${1:-origin/main}...HEAD"
}

# Same list as a tree (with --fromfile, "." makes tree read paths from stdin)
git-diff-filename-tree() {
    git diff --name-only "${1:-origin/main}...HEAD" | tree --fromfile .
}

# Clone over ssh; bare repo name assumes $DEFAULT_GITHUB_ORG (set in ~/.profile)
clone() {
    local repo="${1%.git}"
    if [[ -z "$repo" ]]; then
        echo "usage: clone <repo|org/repo> [git clone args...]" >&2
        return 1
    fi
    if [[ "$repo" != */* ]]; then
        if [[ -z "$DEFAULT_GITHUB_ORG" ]]; then
            echo "clone: DEFAULT_GITHUB_ORG unset - export it in ~/.profile, or pass <org/repo>" >&2
            return 1
        fi
        repo="$DEFAULT_GITHUB_ORG/$repo"
    fi
    git clone "git@github.com:${repo}.git" "${@:2}"
}

### AWS
# Looks up the registry endpoint per call rather than at every shell startup
_ecr_login() {
	local endpoint
	endpoint=$(aws ecr get-authorization-token --output text --query 'authorizationData[].proxyEndpoint' --region us-west-2) || return
	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin "$endpoint"
}
