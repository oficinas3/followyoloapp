# followyoloapp
FollowYolo app, an app to rent the robots on the market to the FollowYolo project.

## Requiriments
1. Android Studio 
1. Flutter SDK installed

__Installation__

Downlaod the Android 
Android Studio

https://developer.android.com/studio


Flutter SDK Download 

https://flutter.dev/docs/get-started/install

__Installation Instructions for the Flutter SDK__
- Flutter SDK Installation on Windows 

https://flutter.dev/docs/get-started/install/windows

- Flutter SDK Installation on MacOs

https://flutter.dev/docs/get-started/install/macos

- Flutter SDK Installation on Linux 

https://flutter.dev/docs/get-started/install/linux


# To Run:
First 
```
git clone gitproject.git
```

And then you can choose where you want to run it 

## Android Studio 
Open the project on Android Studio and click on the Button 'Run'

If you plug a Android Phone you can run the project on it or you can run on a Android Simulator 

## Visual Studio Code
Open the folder on the VSCode and you can click on: 
- Run > Run Without Debbuging 
- Run > Start Debbuging

If you plug a Android Phone you can run the project on it or you can run on a Android Simulator 

## On the terminal

Cd to the location where you cloned the project
```
cd /path/to/main/directory
```

And run the command:
```
flutter run
```
If you plug a Android Phone you can run the project on it or you can run on a Android Simulator.


Or build the apk with this command
```
flutter build apk --split-per-abi
```

The release and debbuging apks will be on the folder:
```
followyolo/build/app/outputs/apk/release/
```
and 
```
followyolo/build/app/outputs/apk/debug/
```


If it doesn't run, this will delete the broken dependencies
```
flutter clean
flutter pub get
```

Then try to run again, it will download and put on the correct path:
```
flutter run
```


On Linux you may have to use this command to be able to build the project
```
sudo chown -R $USER:root /path/to/main/directory
```
