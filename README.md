# TV Shows

Made for the [Infinum](https://infinum.com/) Flutter Academy

__Not responsive__, made for Pixel 3a.
App architecture as described in [Infinum Flutter Handbook](https://infinum.com/handbook/flutter/architecture/architecture).

## Features
- Sign in & Register
- Fetch data from the [API](https://tv-shows.infinum.academy/api/v1/docs/index.html)
- Submit reviews for shows
- Update user email and profile picture
- Couple of simple animations/transitions incl. 1 Lottie animation
- Mock tests, widget tests and golden tests

## Code features

* [Provider](https://pub.dev/packages/provider) for state management
* [Request Provider](https://github.com/infinum/flutter-bits/tree/master/request_provider) for handling request states
* [Dio](https://pub.dev/packages/dio) for network requests
  * Implemented request interceptors that append token and other data to request headers
* [Hive](https://pub.dev/packages/hive) for storing user data (id, email, profile picture url) on device
* [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) for storing sensitive data (token type, token, uid, client) on device
* [Mockito](https://pub.dev/packages/mockito) for mock tests
* [Golden toolkit](https://pub.dev/packages/golden_toolkit) for golden tests
* [FlutterGen](https://pub.dev/packages/flutter_gen) for type safe assets

## Installation

1. Start the Android or iOS emulator
2. Open terminal in project root
3. Execute ```flutter pub get```
4. Execute ```flutter run``` 

## Screenshots
![Login screen](https://i.imgur.com/PzDCQBvm.gif)
![Main screen](https://i.imgur.com/PQh8upwm.png)
![User profile bottom drawer](https://i.imgur.com/wzR3QWim.png)
![Show details](https://i.imgur.com/ugjYA7mm.png)
![Review form](https://i.imgur.com/IvAGfOMm.png)
