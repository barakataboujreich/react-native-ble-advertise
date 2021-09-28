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
