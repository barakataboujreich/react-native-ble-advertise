import { Platform } from 'react-native';


const BleAdvertise = Platform.OS === 'web'
  ? null
  : require('./NativeBleAdvertise').default;

  class BleAdvertiser {
    broadcast(uuid: string, myMajor: number, myMinor: number): Promise<string> {
      return new Promise<string>((fulfill, reject) => {
        BleAdvertise.broadcast(uuid, myMajor, myMinor).then(() => {
          fulfill("success");
        }).catch((err: string) => {
          reject(err);
        })
      });
    }
  
    stopBroadcast(): Promise<string> {
      return new Promise<string>((fulfill, reject) => {
        BleAdvertise.stopBroadcast().then(() => {
          fulfill("success");
        }).catch((err: string) => {
          reject(err);
        });
      });
    }
  
    checkIfBLESupported(): Promise<string> {
      return new Promise<string>((fulfill, reject) => {
        BleAdvertise.checkIfBLESupported().then((data: string) => {
          fulfill(data);
        }).catch((err: string) => {
          reject(err);
        });
      });
    }
  
    setCompanyId(companyID: number): void {
      BleAdvertise.setCompanyId(companyID);
    }
  }
  
  
  export default new BleAdvertiser();
