# followyoloapp
FollowYolo app 

## Requiriments
1. Android Studio 
1. Flutter SDK installed

__Installation__
Downlaod the Android 
Android Studio
https://developer.android.com/studio


Flutter SDK Download 
https://flutter.dev/docs/get-started/install

Flutter SDK Installation on Windows 
https://flutter.dev/docs/get-started/install/windows

Flutter SDK Installation on MacOs
https://flutter.dev/docs/get-started/install/macos

Flutter SDK Installation on Linux 
https://flutter.dev/docs/get-started/install/linux


# To Run:
first
```
git clone 
```

And then you can choose where it 

# Android Studio 
Open the project on Android Studio and run


# Visual Studio Code
Open the folder on the VSCode and you can click on: 
- Run > Run Without Debbuging 
- Run > Start Debbugin

If you plug a Android Phone you can run the project on it or you can run on a Android Simulator 

## On the terminal

Cd to the Git folder and run the command:
You can just type
```
flutter run
```

Or build the apk, this will 
```
flutter build apk --split-per-abi
```

If it doesn't run, this will delete the broken dependencies
```
flutter clean
flutter pub get
```

Then try to run again, it will download and put on the correct path:
```
flutter run



On Linux you may have to use this command to be able to build the project
```
sudo chown -R $USER:root /path/to/main/directory
```
