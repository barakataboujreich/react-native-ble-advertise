
//
//  BleAdvertise.h
//  Kindoo
//
//  Created by barakat abou jreich on 3/1/23.
//
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTLog.h>
#import <CoreBluetooth/CoreBluetooth.h>
@import CoreLocation;

@interface BleAdvertise : RCTEventEmitter <RCTBridgeModule, CBCentralManagerDelegate, CBPeripheralManagerDelegate, CBPeripheralDelegate> {
    CBCentralManager *centralManager;
    CBPeripheralManager *peripheralManager;
    CLBeaconRegion *beaconRegion;
}



@end
/* BleAdvertise_h */
