import { registerPlugin } from '@capacitor/core';

import type { FastGeolocationPlugin } from './definitions';

const FastGeolocation = registerPlugin<FastGeolocationPlugin>('FastGeolocation', {
  web: () => import('./web').then((m) => new m.FastGeolocationWeb()),
});

export * from './definitions';
export { FastGeolocation };
