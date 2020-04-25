#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5ea41e6a22304200197a5985/webhook/build/pull > /dev/null
if [[ -z "f80fa0df1a15d35b40bbc5a65f3d5256f1defcebbdc5a67389d9d98eba8df177" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5ea41e6a22304200197a5985 
fi
curl -s -X POST https://api.stackbit.com/project/5ea41e6a22304200197a5985/webhook/build/ssgbuild > /dev/null
hugo
./inject-netlify-identity-widget.js public
curl -s -X POST https://api.stackbit.com/project/5ea41e6a22304200197a5985/webhook/build/publish > /dev/null
