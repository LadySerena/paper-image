#!/usr/bin/env bash

decryptedDir="secrets/decrypted"
encryptedDir="secrets/encrypted"
files=($encryptedDir/*)

for file in "${files[@]}"; do
  echo $file
  filename="$(basename -- "$file")"
  sops -d "$encryptedDir/$filename" >"$decryptedDir/$filename"
done
ls -al $decryptedDir
