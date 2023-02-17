#!/bin/sh
appname=$1
package=$2
version=$3
buildNbr=$4

#----- change files

#remove files
rm assets/fonts/*
rm android/app/google-services.json
rm assets/icon.png
rm lib/core/common/color.dart
rm lib/core/common/url_changed.dart

#copy files
cp config/firebaseJson/* android/app/
cp config/fonts/*        assets/fonts/
cp config/icons/*        assets/
cp config/colors/*       lib/core/common/
cp config/url/*          lib/core/common/

#change name app
flutter pub global run rename --appname $appname

#change package name
flutter pub run change_app_package_name:main $package

#clean project
flutter clean
flutter pub get

#generate icons
flutter pub run flutter_launcher_icons

#change version app
flutter build apk --build-name=$version --build-number=$buildNbr
