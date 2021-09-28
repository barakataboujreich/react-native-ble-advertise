module.exports = {
  dependencies: {
    'react-native-ble-advertise': {
        platforms: {
            android: {
                "packageImportPath": "import com.reactnativebleadvertise;",
                "packageInstance": "new BLEAdvertisePackage()"
            }
        }
    }
  }
};