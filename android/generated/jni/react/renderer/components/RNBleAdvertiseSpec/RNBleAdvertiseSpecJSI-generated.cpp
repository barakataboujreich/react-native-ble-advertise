/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleCpp.js
 */

#include "RNBleAdvertiseSpecJSI.h"

namespace facebook::react {

static jsi::Value __hostFunction_NativeBleAdvertiseCxxSpecJSI_broadcast(jsi::Runtime &rt, TurboModule &turboModule, const jsi::Value* args, size_t count) {
  return static_cast<NativeBleAdvertiseCxxSpecJSI *>(&turboModule)->broadcast(
    rt,
    count <= 0 ? throw jsi::JSError(rt, "Expected argument in position 0 to be passed") : args[0].asString(rt),
    count <= 1 ? throw jsi::JSError(rt, "Expected argument in position 1 to be passed") : args[1].asNumber(),
    count <= 2 ? throw jsi::JSError(rt, "Expected argument in position 2 to be passed") : args[2].asNumber()
  );
}
static jsi::Value __hostFunction_NativeBleAdvertiseCxxSpecJSI_stopBroadcast(jsi::Runtime &rt, TurboModule &turboModule, const jsi::Value* args, size_t count) {
  return static_cast<NativeBleAdvertiseCxxSpecJSI *>(&turboModule)->stopBroadcast(
    rt
  );
}
static jsi::Value __hostFunction_NativeBleAdvertiseCxxSpecJSI_checkIfBLESupported(jsi::Runtime &rt, TurboModule &turboModule, const jsi::Value* args, size_t count) {
  return static_cast<NativeBleAdvertiseCxxSpecJSI *>(&turboModule)->checkIfBLESupported(
    rt
  );
}
static jsi::Value __hostFunction_NativeBleAdvertiseCxxSpecJSI_setCompanyId(jsi::Runtime &rt, TurboModule &turboModule, const jsi::Value* args, size_t count) {
  static_cast<NativeBleAdvertiseCxxSpecJSI *>(&turboModule)->setCompanyId(
    rt,
    count <= 0 ? throw jsi::JSError(rt, "Expected argument in position 0 to be passed") : args[0].asNumber()
  );
  return jsi::Value::undefined();
}

NativeBleAdvertiseCxxSpecJSI::NativeBleAdvertiseCxxSpecJSI(std::shared_ptr<CallInvoker> jsInvoker)
  : TurboModule("BleAdvertise", jsInvoker) {
  methodMap_["broadcast"] = MethodMetadata {3, __hostFunction_NativeBleAdvertiseCxxSpecJSI_broadcast};
  methodMap_["stopBroadcast"] = MethodMetadata {0, __hostFunction_NativeBleAdvertiseCxxSpecJSI_stopBroadcast};
  methodMap_["checkIfBLESupported"] = MethodMetadata {0, __hostFunction_NativeBleAdvertiseCxxSpecJSI_checkIfBLESupported};
  methodMap_["setCompanyId"] = MethodMetadata {1, __hostFunction_NativeBleAdvertiseCxxSpecJSI_setCompanyId};
}


} // namespace facebook::react
