# react-native-ble-advertise

BLE iBeacon advertiser for react native

## Supported Platforms
- Android
- IOS

## Installation

for react native > 0.74 and new architecture is enable use version > 0.X.X
for react native < 0.76 and new architecture is not enabled use versions 0.X.X

```sh
npm install react-native-ble-advertise
```

```sh
yarn add react-native-ble-advertise
```

##### Android - Update Manifest

```xml
// file: android/app/src/main/AndroidManifest.xml
<!-- Add xmlns:tools -->
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="YOUR_PACKAGE_NAME">

    <uses-permission android:name="android.permission.BLUETOOTH" android:maxSdkVersion="30" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" android:maxSdkVersion="30" />

    <!-- Only when targeting Android 12 or higher -->
    <!-- Please make sure you read the following documentation to have a
         better understanding of the new permissions.
         https://developer.android.com/guide/topics/connectivity/bluetooth/permissions#assert-never-for-location
         -->

    <!-- Needed only if your app makes the device discoverable to Bluetooth devices. -->
    <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
...
```
##### iOS 
```
cd ios
pod install

Add NSBluetoothAlwaysUsageDescription to your Info.plist
```
## Usage

##### Android only
-Before accessing the bluetooth we need to request the permission.
```js
import {Platform, PermissionsAndroid} from "react-native";
// ...
if (Platform.OS === 'android') {
   var permissionsRequiredToBeAccepted = [
     PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
   ];

   if (Platform.Version >= 31) {
     permissionsRequiredToBeAccepted.push(...[
       PermissionsAndroid.PERMISSIONS.BLUETOOTH_ADVERTISE
     ]);
   }

   PermissionsAndroid.requestMultiple(permissionsRequiredToBeAccepted).then(permissionRequestResult => {});
}
```

##### Android only
- Before starting any advertisement, you need to set the company ID.
you need to register your ble company identifier on https://www.bluetooth.com/
the company id is 2 bytes.
for demo purposes we will use 00E0. On ios the company code will be apple's default
```js
import BleAdvertise from "react-native-ble-advertise";
// ...
BleAdvertise.setCompanyId(0x00E0);
```



- To start advertising, you will need to prepare a 16 byte UUID, 2 byte Major, and 2 byte Minor

```js
import BleAdvertise from "react-native-ble-advertise";
// ...
const uuid = "44C13E43-097A-9C9F-537F-5666A6840C08";
const major = parseInt("CD00", 16);
const minor = parseInt("0003", 16);

BLEAdvertise.broadcast(uuid, major, minor)
                .then(success => {
                    console.log('broadcast started');
                }).catch(error => { 
		    console.log('broadcast failed with: ' + error);
		});
```
the advertising data as per example will be broadcasted in the following order

E000021544C13E43097A9C9F537F5666A6840C08CD000003

companyID (E000), iBeacon identifier(0215), UUID(44C13E43097A9C9F537F5666A6840C08), Major(CD00), Minor(0003)



- To stop advertising, you need to call the stopBroadcast method
```js
import BleAdvertise from "react-native-ble-advertise";
// ...
BLEAdvertise.stopBroadcast()
                .then(success => {
                    console.log('broadcast stopped');
                }).catch(error => { 
		    console.log('broadcast failed to stop with: ' + error);
		});
```

## License

Apache-2.0