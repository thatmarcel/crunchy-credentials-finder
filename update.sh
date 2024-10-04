#!/bin/bash

set -e

if [[ ! -z $G_TOKEN ]]; then
    echo $G_TOKEN | gh auth login --with-token
    git config --global user.name $G_USER_NAME
    git config --global user.email $G_USER_EMAIL
fi

./find.sh

git clone "https://github.com/thatmarcel/crunchy-credentials-offsets"
cd crunchy-credentials-offsets
cp -f ../output/client-id-offset.txt .
cp -f ../output/client-secret-offset.txt .
cp -f ../output/version-code.txt .
cp -f ../output/version-name.txt .
git add client-id-offset.txt client-secret-offset.txt version-code.txt version-name.txt
git commit -m "Update offsets"
git push origin main

cd ..
rm -rf output crunchy-credentials-offsets

exit 0