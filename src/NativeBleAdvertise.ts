import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  broadcast(uuid: string, myMajor: number, myMinor: number): Promise<string>;
  stopBroadcast(): Promise<string>;
  checkIfBLESupported(): Promise<string>;
  setCompanyId(companyID: number): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('BleAdvertise');
