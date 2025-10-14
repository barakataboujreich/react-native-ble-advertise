//
//  BleAdvertiseImpl.swift
//  react-native-ble-advertise
//
//

import Foundation
import CoreBluetooth
import CoreLocation

@objc public class BleAdvertiseImpl: NSObject {
 
  var peripheralManager: CBPeripheralManager? = nil
  var region: CLBeaconRegion? = nil

  @objc public func broadcast(uid: String, major: Double, minor: Double, resolve: @escaping(String) -> Void, reject: @escaping(String, String?) -> Void ) {
      
      if(peripheralManager == nil)
      {
        initBle();
      }
      
      if(peripheralManager?.state != CBManagerState.poweredOn)
      {
        
        reject("BLE_NOT_POWERED_ON", "Ble is not powered on");
        return;
      }
      
      
      let region = createBeaconRegion(uid: uid, prmajor: UInt16(major), prminor: UInt16(minor))
      self.region = region;
      advertiseDevice();
      resolve("Advertising started")
    }
    
    @objc public func checkIfBLESupported(resolve: @escaping(String) -> Void, reject: @escaping(String, String?) -> Void){
      
      if(peripheralManager == nil)
      {
        initBle();
        if(peripheralManager == nil)
        {
          reject("BLE_NOT_SUPPORTED", "100")
          return
        }
        
      }
      
      resolve("80")
      
      
    }
    
    @objc public func setCompanyId(companyID: Double){
      if(peripheralManager == nil)
      {
        initBle();
      }
    }
    
    @objc public func stopBroadcast(resolve: @escaping(String) -> Void, reject: @escaping(String, String?) -> Void){
      
      if(peripheralManager == nil)
      {
        initBle();
      }
      
      peripheralManager?.stopAdvertising();
      
      resolve("Stopped broadcasting");
    }
  
  private func createBeaconRegion(uid: String, prmajor: UInt16, prminor: UInt16) -> CLBeaconRegion? {
      let proximityUUID = UUID(uuidString:
                                uid)
      let major : CLBeaconMajorValue = prmajor
      let minor : CLBeaconMinorValue =  prminor
      let identifier = "Kindoo"
      
      return CLBeaconRegion(uuid: proximityUUID!,
                            major: major, minor: minor, identifier: identifier)
    }
  
  private func advertiseDevice() {
      
    let peripheralData = region?.peripheralData(withMeasuredPower: nil)
      
      peripheralManager?.startAdvertising(((peripheralData! as NSDictionary) as! [String : Any]))
    }
  
}

extension BleAdvertiseImpl: CBPeripheralManagerDelegate {
  public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    if peripheral.state == .poweredOn {
      
    }
  }
  
  private func initBle(){
    var queue = DispatchQueue.main
    
   peripheralManager = CBPeripheralManager(delegate: self, queue: queue)
  }
}
