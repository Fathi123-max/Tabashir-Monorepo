# Android Release Signing Configuration
# 
# This file provides instructions for generating a release keystore
# and configuring it for the Android app.
#
# IMPORTANT: Never commit the keystore file or keystore.properties to version control!

## Step 1: Generate a new keystore
# Run this command to generate a new keystore:
#
# keytool -genkey -v -keystore ~/upload-keystore.jks \
#   -keyalg RSA -keysize 2048 -validity 10000 -alias upload
#
# You will be prompted to:
# - Enter a password (remember this!)
# - Provide your name, organization, location details
# - Confirm the information is correct

## Step 2: Create keystore.properties
# After generating the keystore, create a file named `key.properties` in the android/ directory:
#
# storePassword=<password you entered above>
# keyPassword=<password you entered above>
# keyAlias=upload
# storeFile=/Users/<your-username>/upload-keystore.jks
#
# IMPORTANT: Add keystore.properties to .gitignore!

## Step 3: Update build.gradle.kts
# The build.gradle.kts file is already configured to read from keystore.properties.
# Just make sure the file exists before building release APKs.

## Step 4: Build release APK
# flutter build apk --release
# or
# flutter build appbundle --release

## Notes:
# - The keystore file is CRITICAL - if you lose it, you CANNOT update your app on Play Store
# - Back up the keystore file securely
# - Consider using Google Play App Signing for additional safety
