import { WebPlugin } from '@capacitor/core';

import type { FastGeolocationPlugin } from './definitions';

export class FastGeolocationWeb extends WebPlugin implements FastGeolocationPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
