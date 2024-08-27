import MusicKit
import StoreKit

@available(iOS 15.0, *)
@objc(MusicKitAuth)
class MusicKitAuth: NSObject {

  @objc(requestAuthorization:withRejecter:)
  func requestAuthorization(
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    Task {
      let status = await MusicAuthorization.request()

      switch status {
      case .authorized:
        resolve("authorized")
      case .denied:
        resolve("denied")
      case .notDetermined:
        resolve("notDetermined")
      case .restricted:
        resolve("restricted")
      @unknown default:
        resolve("unknown")
      }
    }
  }

  @objc(getUserToken:withRejecter:)
  func getUserToken(
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    Task {
      do {
        let defaultTokenProvider = DefaultMusicTokenProvider.init()
        let developerToken = try await defaultTokenProvider.developerToken(
          options: MusicTokenRequestOptions())
        let musicUserTokenProvider = MusicUserTokenProvider()
        let userToken = try await musicUserTokenProvider.userToken(
          for: developerToken, options: MusicTokenRequestOptions())

        let tokens: [String: String] = [
          "developerToken": developerToken,
          "userToken": userToken,
        ]

        resolve(tokens)
      } catch {
        reject("AUTH_ERROR", "Error retrieving user token: \(error.localizedDescription)", error)
      }
    }
  }

  @objc(getUserTokenFromStoreKit:withRejecter:)
  func getUserTokenFromStoreKit(
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    Task {
      do {
        let defaultTokenProvider = DefaultMusicTokenProvider.init()
        let developerToken = try await defaultTokenProvider.developerToken(
          options: MusicTokenRequestOptions())
        let userToken = try await SKCloudServiceController().requestUserToken(
          forDeveloperToken: developerToken)

        resolve(userToken)
      } catch {
        reject("AUTH_ERROR", "Error retrieving user token: \(error.localizedDescription)", error)
      }
    }
  }

  @objc(getUserTokenFromStoreKitFromDevToken:withResolver:withRejecter:)
  func getUserTokenFromStoreKitFromDevToken(
    developerToken: NSString,
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock
  ) {
    SKCloudServiceController().requestUserToken(
      forDeveloperToken: String(developerToken)
    ) { (token, error) in
      if let error = error {
        reject("ERROR", "Error retrieving user token: \(error.localizedDescription)", error)
        return
      }

      resolve(token)
    }
  }
}
