import { registerPlugin } from '@capacitor/core';

import type { FastGeolocationPlugin } from './definitions';

const FastGeolocation = registerPlugin<FastGeolocationPlugin>('FastGeolocation');

export * from './definitions';
export { FastGeolocation };
