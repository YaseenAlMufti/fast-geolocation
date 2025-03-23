export interface FastGeolocationPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
