#!/bin/bash

keytool -genkey -v -keystore ~/debug.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey
keytool -list -v -keystore ~/debug.keystore -alias androiddebugkey -storepass android -keypass android
cp ~/debug.keystore ~/.android

# In `.android` flutter project folder
# ./gradlew signingReport