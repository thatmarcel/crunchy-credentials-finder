#!/bin/bash

./find.sh

git clone "https://github.com/thatmarcel/crunchy-credentials-offsets"
cd crunchy-credentials-offsets
rm -f client-id-offset.txt client-secret-offset.txt
cp ../output/client-id-offset.txt .
cp ../output/client-secret-offset.txt .
git add client-id-offset.txt client-secret-offset.txt
git commit -m "Update offsets"
git push origin main

cd ..
rm -rf output crunchy-credentials-offsets