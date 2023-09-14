A Pokemon app

**This application has been tested on:**
- Android Redmi 10 (Android 12, MIUI 13)
- Android Studio Emulator (SDK 30)

**Minimum Requirement:**
- Android SDK 21 (Android 5.0)
  
**Recommended Requirement:**
- Android SDK 30 (Android 11)

**Instruction to build and run app:**
- Download the project and open using visual studio code
- Go to pubspec.yaml and run "flutter pub get" to download required library
- Run it on simulator or real device

**Feature and Tech Stack:**
- Pages:
    - Auth, Sign In & Sign Up
    - Pokemon List By Type
    - Pokemon Detail
    - Pokemon Favorite
    - Profile
- Provider State Management
- Dependency Injection using GetIt
- Offline capability using SQFLITE to store the data locally for favorite pokemon
- Image loading and caching
- Implement filter pokemon list by type
- Implement search pokemon list
- Implement add favorite pokemon
- Implement change profile photo from camera or gallery
