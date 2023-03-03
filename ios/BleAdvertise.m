
//
//  BleAdvertise.m
//  Kindoo
//
//  Created by barakat abou jreich on 3/1/23.
//

#import "BleAdvertise.h"
@import CoreBluetooth;
@import CoreLocation;

@implementation BleAdvertise
RCT_EXPORT_MODULE(BleAdvertise)

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onBTStatusChange"];
}

RCT_EXPORT_METHOD(setCompanyId: (nonnull NSNumber *)companyId){
    RCTLogInfo(@"setCompanyId function called %@", companyId);
    self->peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

RCT_EXPORT_METHOD(broadcast:(nonnull NSString *)uid major:(nonnull NSNumber *)major minor:(nonnull NSNumber *)minor resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
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

- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    NSLog(@"Check BT status");
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithCapacity:1];
    switch (central.state) {
        case CBManagerStatePoweredOff:
            params[@"enabled"] = @NO;
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBManagerStatePoweredOn:
            params[@"enabled"] = @YES;
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            break;
        case CBManagerStateResetting:
            params[@"enabled"] = @NO;
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBManagerStateUnauthorized:
            params[@"enabled"] = @NO;
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBManagerStateUnknown:
            params[@"enabled"] = @NO;
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBManagerStateUnsupported:
            params[@"enabled"] = @NO;
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            break;
    }
    [self sendEventWithName:@"onBTStatusChange" body:params];
}

- (void)peripheralManagerDidUpdateState:(nonnull CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        case CBManagerStatePoweredOn:
            NSLog(@"%ld, CBPeripheralManagerStatePoweredOn", peripheral.state);
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"%ld, CBPeripheralManagerStatePoweredOff", peripheral.state);
            break;
        case CBManagerStateResetting:
            NSLog(@"%ld, CBPeripheralManagerStateResetting", peripheral.state);
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"%ld, CBPeripheralManagerStateUnauthorized", peripheral.state);
            break;
        case CBManagerStateUnsupported:
            NSLog(@"%ld, CBPeripheralManagerStateUnsupported", peripheral.state);
            break;
        case CBManagerStateUnknown:
            NSLog(@"%ld, CBPeripheralManagerStateUnknown", peripheral.state);
            break;
        default:
            break;
    }
}// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(double)a withB:(double)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    NSNumber *result = @(a * b);

    resolve(result);
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeBleAdvertiseSpecJSI>(params);
}
#endif

@end
