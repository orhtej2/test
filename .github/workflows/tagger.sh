#!/bin/bash

toml_to_json() {
    python3 -c 'import toml, json, sys; print(json.dumps(toml.load(sys.stdin)))'
}

if [ -f manifest.json ];
then
  current_version=$(cat manifest.json | jq -j ".version" | sed -e "s/~/-/")
elif [ -f manifest.toml ];
then
  current_version=$(cat manifest.toml | toml_to_json | jq ".version" | sed -e "s/~/-/")
else
  echo No manifest found!
  exit 0
fi

echo Found version $current_version

echo "PROCEED=true" >> $GITHUB_ENV
echo "VERSION=$current_version" >> $GITHUB_ENV
