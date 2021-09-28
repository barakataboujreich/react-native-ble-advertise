#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTLog.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BleAdvertise : RCTEventEmitter <RCTBridgeModule, CBPeripheralManagerDelegate, CBPeripheralDelegate>{
    CBPeripheralManager *peripheralManager;
    CLBeaconRegion *beaconRegion;
}

@end
