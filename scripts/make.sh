#!/bin/bash

CHROME_EXTENSION="seipp-chrome.zip"
FIREFOX_EXTENSION="seipp-firefox.zip"

rm -f $CHROME_EXTENSION
rm -f $FIREFOX_EXTENSION

# Cria o aquivo para o Chrome/Edge
jq 'del(.background.scripts)' manifest.json > temp.json && mv temp.json manifest.json
zip -r $CHROME_EXTENSION . -x ".git*" ".vscode*" ".github*" "scripts/*" "node_modules/*"
zip -r $CHROME_EXTENSION node_modules/jquery*
echo "Create $CHROME_EXTENSION"

# Cria o arquivo para o Firefox
git checkout manifest.json
jq 'del(.background.service_worker)' manifest.json > temp.json && mv temp.json manifest.json
zip -r $FIREFOX_EXTENSION . -x ".git*" ".vscode*" ".github*" "scripts/*" "node_modules/*"
zip -r $FIREFOX_EXTENSION node_modules/jquery*
echo "Create $FIREFOX_EXTENSION"

git checkout manifest.json
