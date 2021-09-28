#import "BleAdvertise.h"
@import CoreBluetooth;

@implementation BleAdvertise

RCT_EXPORT_MODULE(BleAdvertise)

RCT_EXPORT_METHOD(setCompanyId: (nonnull NSNumber *)companyId){
    RCTLogInfo(@"setCompanyId function called %@", companyId);
    self->peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

RCT_EXPORT_METHOD(broadcast:(NSString *)uid major:(int)major minor:(int)minor resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"Broadcast function called %@ with major %@ and minor %@", uid, major, minor);
    NSString *identifier = @"Kindoo";

    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:uid];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:major minor:minor identifier:identifier];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;

    if (!self.peripheralManager)
      self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];

    if (self.peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        RCTLogInfo(@"Peripheral manager is off.");
        return;
    }

    time_t t;
    srand((unsigned) time(&t));
    
    UInt16 major = [self.beaconRegion.major unsignedShortValue];
    UInt16 minor = [self.beaconRegion.minor unsignedShortValue];
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:self.beaconRegion.proximityUUID major: major minor: minor identifier:self.beaconRegion.identifier];
    NSDictionary *beaconPeripheralData = [region peripheralDataWithMeasuredPower:nil];
    [self.peripheralManager startAdvertising:beaconPeripheralData];

    resolve(@"Broadcasting");
}

RCT_EXPORT_METHOD(stopBroadcast:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    [self.peripheralManager stopAdvertising];
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
