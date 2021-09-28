export as namespace BleAdvertise;

export interface BroadcastOptions {
    txPowerLevel?: number;
    advertiseMode?: number;
    includeDeviceName?: boolean;
    includeTxPowerLevel?: boolean;
    connectable?: boolean;
}

export function setCompanyId(companyId: number): void;
export function broadcast(uid: String, major: number, minor: number): Promise<string>;
export function stopBroadcast(): Promise<string>;
export function enableAdapter(): void;
export function disableAdapter(): void;
export function getAdapterState(): Promise<string>;
export function checkIfBLESupported(): Promise<string>;