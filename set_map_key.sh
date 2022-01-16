#!/bin/bash
git update-index --skip-worktree android/app/src/main/AndroidManifest.xml
git update-index --skip-worktree ios/Runner/AppDelegate.swift
git update-index --skip-worktree web/index.html
if (($# == 0)); then
  echo "Requieres option -k with google map key as argument" >&2
  exit 1
fi
while getopts k: opt; do
  case $opt in
    k)
      map_key=$OPTARG
      ;;
  esac
done
sed -i -e "s/MAPS_KEY_HERE/$map_key/g" android/app/src/main/AndroidManifest.xml
sed -i -e "s/MAPS_KEY_HERE/$map_key/g" ios/Runner/AppDelegate.swift
sed -i -e "s/MAPS_KEY_HERE/$map_key/g" web/index.html
exit 0