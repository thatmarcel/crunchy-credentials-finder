#!/bin/bash

wget "https://apkpure.com/crunchyroll/com.crunchyroll.crunchyroid/versions" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.3" -O crunchyroll-versions.html
rg "data-dt-versioncode=\"([0-9]{3,4})\"" crunchyroll-versions.html -o -I -N -r \$1 > version-codes.txt
cut -d: -f 2 version-codes.txt | sort -n | tail -n 1 > latest-version-code.txt
wget "https://d.apkpure.com/b/APK/com.crunchyroll.crunchyroid?versionCode=$(cat latest-version-code.txt)" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.3" -O crunchyroll.apk
rm -f version-codes.txt latest-version-code.txt crunchyroll-versions.html
apktool d -f crunchyroll.apk
rm -rf output
mkdir output
rg "https://pl.crunchyroll.com" crunchyroll/smali_classes2 -l > matches.txt
rg "const-string v3, \"(\b[a-zA-Z0-9\-]{20}\b)\"" $(cat matches.txt) -o -I -N -r \$1 > output/client-id.txt
rg "const-string v3, \"(\b[a-zA-Z0-9\-]{32}\b)\"" $(cat matches.txt) -o -I -N -r \$1 > output/client-secret.txt
rm -f matches.txt
rg "versionCode: ([0-9]{3,4})" crunchyroll/apktool.yml -o -I -N -r \$1 > output/version-code.txt
rg "versionName: ([0-9.]*)" crunchyroll/apktool.yml -o -I -N -r \$1 > output/version-name.txt
rm -rf crunchyroll
unzip -o crunchyroll.apk -d crunchyroll-app-contents
rm -f crunchyroll.apk
printf "%x\n" $(rg $(cat output/client-id.txt) crunchyroll-app-contents/classes2.dex -a -o -I -N -b | rg "(.*):" -o -r \$1) > output/client-id-offset.txt
printf "%x\n" $(rg $(cat output/client-secret.txt) crunchyroll-app-contents/classes2.dex -a -o -I -N -b | rg "(.*):" -o -r \$1) > output/client-secret-offset.txt
rm -rf crunchyroll-app-contents