#import "BleAdvertise.h"
#import "react_native_ble_advertise/react_native_ble_advertise-Swift.h"

@implementation BleAdvertise {
  BleAdvertiseImpl *moduleImpl;
}

- (instancetype) init {
  self = [super init];
  if(self) {
    moduleImpl = [BleAdvertiseImpl new];
    
  }
  return self;
}

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeBleAdvertiseSpecJSI>(params);
}

- (void)broadcast:(NSString *)uuid myMajor:(double)myMajor myMinor:(double)myMinor resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  
  [moduleImpl broadcastWithUid:uuid major:myMajor minor:myMinor resolve:^(NSString * _Nonnull success) {
    resolve(success);
  } reject:^(NSString * _Nonnull code, NSString * _Nonnull message) {
    NSError *error = [NSError errorWithDomain:@"DlogError" code:0 userInfo:@{NSLocalizedDescriptionKey: @"error happened"}];
    reject(code, message, error);
  }];
}

- (void)checkIfBLESupported:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject { 
  [moduleImpl checkIfBLESupportedWithResolve:^(NSString * _Nonnull success) {
    resolve(success);
  } reject:^(NSString * _Nonnull code, NSString * _Nonnull message) {
    reject(code, message, nil);
  }];
}

- (void)setCompanyId:(double)companyID { 
  [moduleImpl setCompanyIdWithCompanyID:companyID];
}

- (void)stopBroadcast:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject { 
  [moduleImpl stopBroadcastWithResolve:^(NSString * _Nonnull success) {
    resolve(success);
  } reject:^(NSString * _Nonnull code, NSString * _Nonnull message) {
    reject(code, message, nil);
  }];
}

@end
