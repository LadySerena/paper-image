#!/usr/bin/env bash

decryptedDir="secrets/decrypted"
encryptedDir="secrets/encrypted"
files=($decryptedDir/*)

for file in "${files[@]}"; do
  filename="$(basename -- "$file")"
  sops -e "$decryptedDir/$filename" > "$encryptedDir/$filename"
done
