#!/usr/bin/env sh

# abort on errors
set -e

# build
yarn run build

# navigate into the build output directory
cd .vuepress/dist

# if you are deploying to a custom domain
echo 'apidoc.aidpay.io' > CNAME

git init
git add -A
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:AidCoinCo/aidpay-api-doc.git master:gh-pages

cd -
