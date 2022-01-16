#!/bin/bash
git update-index --skip-worktree android/app/src/main/AndroidManifest.xml
git update-index --skip-worktree ios/Runner/AppDelegate.swift
git update-index --skip-worktree web/index.html
key_alias='MAPS_KEY_HERE'
while getopts k:r: opt; do
  case $opt in
    k)
      map_key=$OPTARG
      ;;
    r)
      key_alias=$OPTARG
      ;;
  esac
done
if [ -z "$map_key" ]; then
  echo 'Missing required Google Map key' >&2
  exit 1
fi
sed -i -e "s/$key_alias/$map_key/g" android/app/src/main/AndroidManifest.xml
sed -i -e "s/$key_alias/$map_key/g" ios/Runner/AppDelegate.swift
sed -i -e "s/$key_alias/$map_key/g" web/index.html
exit 0