import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  Text,
  TextInput,
  Button,
  Platform,
  PermissionsAndroid,
  Alert
} from 'react-native';

import BleAdvertise from "react-native-ble-advertise";

const EMPTY = '<empty>';

function App(): React.JSX.Element {

  const [state, setState] = React.useState<
    string | null
  >(null);

  const uuid = "44C13E43-097A-9C9F-537F-5666A6840C08";
  const major = parseInt("CD00", 16);
  const minor = parseInt("0003", 16);

  React.useEffect(() => {
    
    

    if (Platform.OS === 'android') {
      var permissionsRequiredToBeAccepted = [
        PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
      ];

      if (Platform.Version >= 31) {
        permissionsRequiredToBeAccepted.push(...[
          PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN,
          PermissionsAndroid.PERMISSIONS.BLUETOOTH_ADVERTISE,
          PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT,
        ]);
      }

      PermissionsAndroid.requestMultiple(permissionsRequiredToBeAccepted).then(permissionRequestResult => {
        
          BleAdvertise.setCompanyId(0x00E0);
          setState("company id set");
        
      });
    }
    else{
      BleAdvertise.setCompanyId(0x00E0);
    }

    
  }, []);

  function startBroadcast() {
    BleAdvertise.broadcast(uuid, major, minor).then(success => {
      setState("broadcase started");
    }).catch(error => {
      console.log(error);
      Alert.alert(error)
      setState('broadcast failed with: ' + error);
    });
  }

  function stopBroadcast() {
    BleAdvertise.stopBroadcast().then(success => {
      setState('broadcast stopped');
    }).catch(error => {
      setState('broadcast failed to stop with: ' + error);
    });
  }

  function checkIfBLESupported() {
    BleAdvertise.checkIfBLESupported().then((data) => {
      setState(data);
    })
  }

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <Text style={styles.text}>
        Current state is: {state ?? 'No state'}
      </Text>
      <Button title="start broadcast" onPress={startBroadcast} />
      <Button title="stop broadcast" onPress={stopBroadcast} />
      <Button title="check ble support" onPress={checkIfBLESupported} />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  text: {
    margin: 10,
    fontSize: 20,
  },
  textInput: {
    margin: 10,
    height: 40,
    borderColor: 'black',
    borderWidth: 1,
    paddingLeft: 5,
    paddingRight: 5,
    borderRadius: 5,
  },
});

export default App;