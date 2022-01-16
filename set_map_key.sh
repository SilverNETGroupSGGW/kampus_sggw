#!/bin/bash
git update-index --skip-worktree android/app/src/main/AndroidManifest.xml
git update-index --skip-worktree ios/Runner/AppDelegate.swift
git update-index --skip-worktree web/index.html
if (($# == 0)); then
  echo "Requieres option -k with google map key as argument" >&2
  exit 1
fi
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
sed -i -e "s/$key_alias/$map_key/g" android/app/src/main/AndroidManifest.xml
sed -i -e "s/$key_alias/$map_key/g" ios/Runner/AppDelegate.swift
sed -i -e "s/$key_alias/$map_key/g" web/index.html
exit 0