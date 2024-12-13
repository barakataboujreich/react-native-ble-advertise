/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleObjCpp
 *
 * We create an umbrella header (and corresponding implementation) here since
 * Cxx compilation in BUCK has a limitation: source-code producing genrule()s
 * must have a single output. More files => more genrule()s => slower builds.
 */

#import "RNBleAdvertiseSpec.h"


@implementation NativeBleAdvertiseSpecBase


- (void)setEventEmitterCallback:(EventEmitterCallbackWrapper *)eventEmitterCallbackWrapper
{
  _eventEmitterCallback = std::move(eventEmitterCallbackWrapper->_eventEmitterCallback);
}
@end


namespace facebook::react {
  
    static facebook::jsi::Value __hostFunction_NativeBleAdvertiseSpecJSI_broadcast(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, PromiseKind, "broadcast", @selector(broadcast:myMajor:myMinor:resolve:reject:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeBleAdvertiseSpecJSI_stopBroadcast(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, PromiseKind, "stopBroadcast", @selector(stopBroadcast:reject:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeBleAdvertiseSpecJSI_checkIfBLESupported(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, PromiseKind, "checkIfBLESupported", @selector(checkIfBLESupported:reject:), args, count);
    }

    static facebook::jsi::Value __hostFunction_NativeBleAdvertiseSpecJSI_setCompanyId(facebook::jsi::Runtime& rt, TurboModule &turboModule, const facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, VoidKind, "setCompanyId", @selector(setCompanyId:), args, count);
    }

  NativeBleAdvertiseSpecJSI::NativeBleAdvertiseSpecJSI(const ObjCTurboModule::InitParams &params)
    : ObjCTurboModule(params) {
      
        methodMap_["broadcast"] = MethodMetadata {3, __hostFunction_NativeBleAdvertiseSpecJSI_broadcast};
        
        
        methodMap_["stopBroadcast"] = MethodMetadata {0, __hostFunction_NativeBleAdvertiseSpecJSI_stopBroadcast};
        
        
        methodMap_["checkIfBLESupported"] = MethodMetadata {0, __hostFunction_NativeBleAdvertiseSpecJSI_checkIfBLESupported};
        
        
        methodMap_["setCompanyId"] = MethodMetadata {1, __hostFunction_NativeBleAdvertiseSpecJSI_setCompanyId};
        
  }
} // namespace facebook::react
