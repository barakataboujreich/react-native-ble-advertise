#import "BleAdvertise.h"
@import CoreBluetooth;
@import CoreLocation;

@implementation BleAdvertise

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setCompanyId: (nonnull NSNumber *)companyId){
    RCTLogInfo(@"setCompanyId function called %@", companyId);
    self->peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

RCT_EXPORT_METHOD(broadcast:(NSString *)uid major:(NSNumber *)major minor:(NSNumber *)minor resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Broadcast function called %@ with major %@ and minor %@", uid, major, minor);
    NSString *identifier = @"Kindoo";

    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:uid];
    beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:major minor:minor identifier:identifier];
    beaconRegion.notifyEntryStateOnDisplay = YES;

    if (!peripheralManager)
      peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];

    if (peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        RCTLogInfo(@"Peripheral manager is off.");
        return;
    }

    time_t t;
    srand((unsigned) time(&t));
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:beaconRegion.proximityUUID major:[major doubleValue] minor:[minor doubleValue] identifier:beaconRegion.identifier];
    NSDictionary *beaconPeripheralData = [region peripheralDataWithMeasuredPower:nil];
    [peripheralManager startAdvertising:beaconPeripheralData];

    resolve(@"Broadcasting");
}

RCT_EXPORT_METHOD(stopBroadcast:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    [peripheralManager stopAdvertising];
    resolve(@"Stopping Broadcast");
}

RCT_EXPORT_METHOD(disableAdapter){
    RCTLogInfo(@"disableAdapter function called");
}

RCT_EXPORT_METHOD(enableAdapter){
    RCTLogInfo(@"enableAdapter function called");
}

RCT_EXPORT_METHOD(getAdapterState:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    switch (centralManager.state) {
        case CBManagerStatePoweredOn:       resolve(@"STATE_ON"); return;
        case CBManagerStatePoweredOff:      resolve(@"STATE_OFF"); return;
        case CBManagerStateResetting:       resolve(@"STATE_TURNING_ON"); return;
        case CBManagerStateUnauthorized:    resolve(@"STATE_OFF"); return;
        case CBManagerStateUnknown:         resolve(@"STATE_OFF"); return;
        case CBManagerStateUnsupported:     resolve(@"STATE_OFF"); return;
    }
}

RCT_EXPORT_METHOD(checkIfBLESupported){
    RCTLogInfo(@"enableAdapter function called");
}
@end
