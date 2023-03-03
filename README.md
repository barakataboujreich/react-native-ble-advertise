# react-native-ble-advertise

BLE iBeacon advertiser for react native

## Supported Platforms
- Android
- IOS

## Installation

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
```
## Usage
- Before starting any advertisement, you need to set the company ID.
you need to register your ble company identifier on https://www.bluetooth.com/
the company id is 2 bytes.
for demo purposes we will use 00E0
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
const major = "CD00";
const minor = "0003";
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
const uuid = "44C13E43-097A-9C9F-537F-5666A6840C08";
const major = "CD00";
const minor = "0003";
BLEAdvertise.stopBroadcast()
                .then(success => {
                    console.log('broadcast stopped');
                }).catch(error => { 
		    console.log('broadcast failed to stop with: ' + error);
		});
```

## License

Apache-2.0
