# https://github.com/myoung34/docker-github-actions-runner
# github-runner your-account/your-repo       AARGHTHISISYOURGHACTIONSTOKEN
function github-runner {
    name=github-runner-${1//\//-}
    org=$(dirname $1)
    repo=$(basename $1)
    tag=${3:-latest}
    docker rm -f $name
    docker run -d --restart=always \
        -e REPO_URL="https://github.com/${org}/${repo}" \
        -e RUNNER_TOKEN="$2" \
        -e RUNNER_NAME="linux-${repo}" \
        -e RUNNER_WORKDIR="/tmp/github-runner-${repo}" \
        -e RUNNER_GROUP="my-group" \
        -e LABELS="ubuntu-latest" \
        -v /var/run/docker.sock:/var/run/docker.sock \
        --name $name myoung34/github-runner:latest
        # -v /tmp/github-runner-${repo}:/tmp/github-runner-${repo} \
}
