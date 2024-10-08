import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-music-kit-auth' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const MusicKitAuth = NativeModules.MusicKitAuth
  ? NativeModules.MusicKitAuth
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export enum AuthStatus {
  Authorized = 'authorized',
  Denied = 'denied',
  NotDetermined = 'notDetermined',
  Restricted = 'restricted',
  Unknown = 'unknown',
}

export interface MusicTokens {
  userToken: string;
  developerToken: string;
}

export function requestAuthorization(): Promise<AuthStatus> {
  return MusicKitAuth.requestAuthorization();
}

export function getUserToken(developerToken?: string): Promise<MusicTokens> {
  if (developerToken === undefined) {
    return MusicKitAuth.getUserToken();
  }

  return MusicKitAuth.getUserTokenWithDeveloperToken(developerToken);
}

export function getUserTokenFromStoreKit(
  developerToken?: string
): Promise<string> {
  if (developerToken === undefined) {
    return MusicKitAuth.getUserTokenFromStoreKit();
  }

  return MusicKitAuth.getUserTokenFromStoreKitFromDevToken(developerToken);
}
