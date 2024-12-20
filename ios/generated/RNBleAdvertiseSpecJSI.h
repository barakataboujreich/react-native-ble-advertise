/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleH.js
 */

#pragma once

#include <ReactCommon/TurboModule.h>
#include <react/bridging/Bridging.h>

namespace facebook::react {


  class JSI_EXPORT NativeBleAdvertiseCxxSpecJSI : public TurboModule {
protected:
  NativeBleAdvertiseCxxSpecJSI(std::shared_ptr<CallInvoker> jsInvoker);

public:
  virtual jsi::Value broadcast(jsi::Runtime &rt, jsi::String uuid, double myMajor, double myMinor) = 0;
  virtual jsi::Value stopBroadcast(jsi::Runtime &rt) = 0;
  virtual jsi::Value checkIfBLESupported(jsi::Runtime &rt) = 0;
  virtual void setCompanyId(jsi::Runtime &rt, double companyID) = 0;

};

template <typename T>
class JSI_EXPORT NativeBleAdvertiseCxxSpec : public TurboModule {
public:
  jsi::Value get(jsi::Runtime &rt, const jsi::PropNameID &propName) override {
    return delegate_.get(rt, propName);
  }

  static constexpr std::string_view kModuleName = "BleAdvertise";

protected:
  NativeBleAdvertiseCxxSpec(std::shared_ptr<CallInvoker> jsInvoker)
    : TurboModule(std::string{NativeBleAdvertiseCxxSpec::kModuleName}, jsInvoker),
      delegate_(reinterpret_cast<T*>(this), jsInvoker) {}


private:
  class Delegate : public NativeBleAdvertiseCxxSpecJSI {
  public:
    Delegate(T *instance, std::shared_ptr<CallInvoker> jsInvoker) :
      NativeBleAdvertiseCxxSpecJSI(std::move(jsInvoker)), instance_(instance) {

    }

    jsi::Value broadcast(jsi::Runtime &rt, jsi::String uuid, double myMajor, double myMinor) override {
      static_assert(
          bridging::getParameterCount(&T::broadcast) == 4,
          "Expected broadcast(...) to have 4 parameters");

      return bridging::callFromJs<jsi::Value>(
          rt, &T::broadcast, jsInvoker_, instance_, std::move(uuid), std::move(myMajor), std::move(myMinor));
    }
    jsi::Value stopBroadcast(jsi::Runtime &rt) override {
      static_assert(
          bridging::getParameterCount(&T::stopBroadcast) == 1,
          "Expected stopBroadcast(...) to have 1 parameters");

      return bridging::callFromJs<jsi::Value>(
          rt, &T::stopBroadcast, jsInvoker_, instance_);
    }
    jsi::Value checkIfBLESupported(jsi::Runtime &rt) override {
      static_assert(
          bridging::getParameterCount(&T::checkIfBLESupported) == 1,
          "Expected checkIfBLESupported(...) to have 1 parameters");

      return bridging::callFromJs<jsi::Value>(
          rt, &T::checkIfBLESupported, jsInvoker_, instance_);
    }
    void setCompanyId(jsi::Runtime &rt, double companyID) override {
      static_assert(
          bridging::getParameterCount(&T::setCompanyId) == 2,
          "Expected setCompanyId(...) to have 2 parameters");

      return bridging::callFromJs<void>(
          rt, &T::setCompanyId, jsInvoker_, instance_, std::move(companyID));
    }

  private:
    friend class NativeBleAdvertiseCxxSpec;
    T *instance_;
  };

  Delegate delegate_;
};

} // namespace facebook::react
