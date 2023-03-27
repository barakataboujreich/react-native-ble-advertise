package com.bleadvertise;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.module.annotations.ReactModule;

import java.util.HashMap;
import java.util.Map;
import java.lang.Object;
import java.util.Hashtable;
import java.util.Set;
import java.util.UUID;
import java.nio.ByteBuffer;


import android.util.Log;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.le.AdvertiseCallback;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.BluetoothLeAdvertiser;

@ReactModule(name = BleAdvertiseModule.NAME)
public class BleAdvertiseModule extends ReactContextBaseJavaModule {
    public static final String NAME = "BleAdvertise";
    private BluetoothAdapter mBluetoothAdapter;
    private static Hashtable<String, BluetoothLeAdvertiser> mAdvertiserList;
    private static Hashtable<String, AdvertiseCallback> mAdvertiserCallbackList;
    private int companyId;
    private Boolean mObservedState;

    public BleAdvertiseModule(ReactApplicationContext reactContext) {
        super(reactContext);

        mAdvertiserList = new Hashtable<String, BluetoothLeAdvertiser>();
        mAdvertiserCallbackList = new Hashtable<String, AdvertiseCallback>();
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter != null) {
            mObservedState = mBluetoothAdapter.isEnabled();
        }
        this.companyId = 0x0000;
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put("ADVERTISE_MODE_BALANCED", AdvertiseSettings.ADVERTISE_MODE_BALANCED);
        constants.put("ADVERTISE_MODE_LOW_LATENCY", AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY);
        constants.put("ADVERTISE_MODE_LOW_POWER", AdvertiseSettings.ADVERTISE_MODE_LOW_POWER);
        constants.put("ADVERTISE_TX_POWER_HIGH", AdvertiseSettings.ADVERTISE_TX_POWER_HIGH);
        constants.put("ADVERTISE_TX_POWER_LOW", AdvertiseSettings.ADVERTISE_TX_POWER_LOW);
        constants.put("ADVERTISE_TX_POWER_MEDIUM", AdvertiseSettings.ADVERTISE_TX_POWER_MEDIUM);
        constants.put("ADVERTISE_TX_POWER_ULTRA_LOW", AdvertiseSettings.ADVERTISE_TX_POWER_ULTRA_LOW);
        return constants;
    }


    // Example method
    // See https://reactnative.dev/docs/native-modules-android
    @ReactMethod
    public void multiply(double a, double b, Promise promise) {
        promise.resolve(a * b);
    }

    @ReactMethod
    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    @ReactMethod
    public void broadcast(String uid, int major, int minor, Promise promise) {
        try {
            if (mBluetoothAdapter == null) {
                Log.w("BleAdvertiseModule", "Device does not support Bluetooth. Adapter is Null");
                promise.reject("Device does not support Bluetooth. Adapter is Null");
                return;
            }

            if (companyId == 0x0000) {
                Log.w("BleAdvertiseModule", "Invalid company id");
                promise.reject("Invalid company id");
                return;
            }

            if (mBluetoothAdapter == null) {
                Log.w("BleAdvertiseModule", "mBluetoothAdapter unavailable");
                promise.reject("mBluetoothAdapter unavailable");
                return;
            }

            if (mBluetoothAdapter.isEnabled() == false) {
                Log.w("BleAdvertiseModule", "Bluetooth disabled");
                promise.reject("Bluetooth disabled");
                return;
            }

            BluetoothLeAdvertiser tempAdvertiser;
            AdvertiseCallback tempCallback;

            if (mAdvertiserList.containsKey(uid)) {
                tempAdvertiser = mAdvertiserList.remove(uid);
                tempCallback = mAdvertiserCallbackList.remove(uid);

                tempAdvertiser.stopAdvertising(tempCallback);
            } else {
                tempAdvertiser = mBluetoothAdapter.getBluetoothLeAdvertiser();
                tempCallback = new BleAdvertiseModule.SimpleAdvertiseCallback(promise);
            }

            if (tempAdvertiser == null) {
                Log.w("BleAdvertiseModule", "Advertiser Not Available unavailable");
                promise.reject("Advertiser unavailable on this device");
                return;
            }

            byte[] majorBytes = intToByteArray(major);
            byte[] minorBytes = intToByteArray(minor);

            byte[] payload = new byte[4];
            payload[0] = majorBytes[0];
            payload[1] = majorBytes[1];
            payload[2] = minorBytes[0];
            payload[3] = minorBytes[1];

            AdvertiseSettings settings = buildAdvertiseSettings();
            AdvertiseData data = buildAdvertiseData(uid, payload);

            tempAdvertiser.startAdvertising(settings, data, tempCallback);

            mAdvertiserList.put(uid, tempAdvertiser);
            mAdvertiserCallbackList.put(uid, tempCallback);
        }
        catch(Exception e) {
           promise.reject(e);
        }
    }

    public static final byte[] intToByteArray(int value) {
        return new byte[] {
                (byte)(value >>> 8),
                (byte)value};
    }

    private AdvertiseSettings buildAdvertiseSettings() {
        AdvertiseSettings.Builder settingsBuilder = new AdvertiseSettings.Builder();

        //if (options != null && options.hasKey("advertiseMode")) {
        //settingsBuilder.setAdvertiseMode(options.getInt("advertiseMode"));
        //}

        //if (options != null && options.hasKey("txPowerLevel")) {
        //settingsBuilder.setTxPowerLevel(options.getInt("txPowerLevel"));
        //}

        //if (options != null && options.hasKey("connectable")) {
        //settingsBuilder.setConnectable(options.getBoolean("connectable"));
        //}
        settingsBuilder.setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY);
        settingsBuilder.setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH);
        return settingsBuilder.build();
    }

    private AdvertiseData buildAdvertiseData(String sUUID, byte[] payload) {
        byte[] MYUUID = UnicodeFormatter.getIdAsByte(UUID.fromString(sUUID));

        AdvertiseData.Builder dataBuilder = new AdvertiseData.Builder();

        ByteBuffer mManufacturerData = ByteBuffer.allocate(24);
        mManufacturerData.put(0, (byte)0x02); // Beacon Identifier
        mManufacturerData.put(1, (byte)0x15); // Beacon Identifier
        for (int i=2; i<18; i++) {
            mManufacturerData.put(i, MYUUID[i-2]); // adding the UUID
        }
        for (int j=18; j< 18 + payload.length; j++){
            mManufacturerData.put(j, payload[j-18]);  //MAJOR MINOR
        }

        mManufacturerData.put(18 + payload.length, (byte)0xC7); // Tx power
        dataBuilder.addManufacturerData(companyId, mManufacturerData.array());

        return dataBuilder.build();
    }

    @ReactMethod
    public void stopBroadcast(final Promise promise) {
        Log.w("BleAdvertiseModule", "Stop Broadcast call");

        if (mBluetoothAdapter == null) {
            Log.w("BleAdvertiseModule", "mBluetoothAdapter unavailable");
            promise.reject("mBluetoothAdapter unavailable");
            return;
        }

        if (mBluetoothAdapter.isEnabled() == false) {
            Log.w("BleAdvertiseModule", "Bluetooth disabled");
            promise.reject("Bluetooth disabled");
            return;
        }

        WritableArray promiseArray= Arguments.createArray();

        Set<String> keys = mAdvertiserList.keySet();
        for (String key : keys) {
            BluetoothLeAdvertiser tempAdvertiser = mAdvertiserList.remove(key);
            AdvertiseCallback tempCallback = mAdvertiserCallbackList.remove(key);
            if (tempAdvertiser != null) {
                tempAdvertiser.stopAdvertising(tempCallback);
                promiseArray.pushString(key);
            }
        }

        promise.resolve(promiseArray);
    }

    @ReactMethod
    public void enableAdapter() {
        if (mBluetoothAdapter == null) {
            return;
        }

        if (mBluetoothAdapter.getState() != BluetoothAdapter.STATE_ON && mBluetoothAdapter.getState() != BluetoothAdapter.STATE_TURNING_ON) {
            mBluetoothAdapter.enable();
        }
    }

    @ReactMethod
    public void disableAdapter() {
        if (mBluetoothAdapter == null) {
            return;
        }

        if (mBluetoothAdapter.getState() != BluetoothAdapter.STATE_OFF && mBluetoothAdapter.getState() != BluetoothAdapter.STATE_TURNING_OFF) {
            mBluetoothAdapter.disable();
        }
    }

    @ReactMethod
    public void checkIfBLESupported(Promise promise) {
        if (mBluetoothAdapter != null) {
            promise.resolve("80");
        }
        else
        {
            promise.resolve("100");
        }
    }

    private class SimpleAdvertiseCallback extends AdvertiseCallback {
        Promise promise;

        public SimpleAdvertiseCallback () {
        }

        public SimpleAdvertiseCallback (Promise promise) {
            this.promise = promise;
        }

        @Override
        public void onStartFailure(int errorCode) {
            super.onStartFailure(errorCode);
            Log.i(NAME, "Advertising failed with code "+ errorCode);

            if (promise == null) return;

            switch (errorCode) {
                case ADVERTISE_FAILED_FEATURE_UNSUPPORTED:
                    promise.reject("This feature is not supported on this platform.", "This feature is not supported on this platform."); break;
                case ADVERTISE_FAILED_TOO_MANY_ADVERTISERS:
                    promise.reject("Failed to start advertising because no advertising instance is available.", "Failed to start advertising because no advertising instance is available."); break;
                case ADVERTISE_FAILED_ALREADY_STARTED:
                    promise.reject("Failed to start advertising as the advertising is already started.", "Failed to start advertising as the advertising is already started."); break;
                case ADVERTISE_FAILED_DATA_TOO_LARGE:
                    promise.reject("Failed to start advertising as the advertise data to be broadcasted is larger than 31 bytes.", "Failed to start advertising as the advertise data to be broadcasted is larger than 31 bytes."); break;
                case ADVERTISE_FAILED_INTERNAL_ERROR:
                    promise.reject("Operation failed due to an internal error.", "Operation failed due to an internal error."); break;
            }
        }

        @Override
        public void onStartSuccess(AdvertiseSettings settingsInEffect) {
            super.onStartSuccess(settingsInEffect);
            Log.i(NAME, "Advertising successful");

            if (promise == null) return;
            promise.resolve(settingsInEffect.toString());
        }
    }
    

}
