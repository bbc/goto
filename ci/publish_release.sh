#!/usr/bin/env bash

set -eu

name=goto
description="Command line tool to jump to a project in your workspace using its initials."
version=$BUILD_NUMBER
tag="v$version"
formula=$name

echo "Creating new release on github for $name"

echo "Creating release: $tag"
release=$(curl -XPOST -H "Authorization:token $GITHUB_ACCESS_TOKEN" --data "{\"tag_name\": \"$tag\", \"target_commitish\": \"master\", \"name\": \"$name\", \"body\": \"$description\", \"draft\": false, \"prerelease\": true}" https://api.github.com/repos/bbc/$name/releases)
 $GITHUB_ACCESS_TOKEN" --data "{\"tag_name\": \"$tag\", \"target_commitish\": \"master\", \"name\": \"$name\", \"body\": \"$description\", \"draft\": false, \"prerelease\": true}" https://api.github.com/repos/bbc/$name/releases)

# Extract the id of the release from the creation response
id=$(echo $release | jq -r .id)
echo "Created release id $id."

echo "Getting the release zip"
url="https://github.com/bbc/$name/archive/${tag}.zip"
curl --location --header "Authorization:token $GITHUB_ACCESS_TOKEN" $url --output ${tag}.zip

release_url="https:\/\/github.com\/bbc\/$name\/archive\/${tag}.zip"
release_sha=$(sha256sum ./${tag}.zip | cut -d' ' -f1)
release_version=$tag

rm -rf homebrew-dpub
git clone git@github.com:bbc/homebrew-dpub.git
cd homebrew-dpub

sed -i -e "s/\_RELEASE_VERSION_/${release_version}/" -e "s/\_RELEASE_URL_/${release_url}/" -e "s/_RELEASE_SHA_/${release_sha}/" templates/${formula}-template
cp templates/${formula}-template Formula/${formula}.rb

git add Formula/${formula}.rb
git commit -m "update $formula"
git push origin
