import MusicKit

@available(iOS 15.0, *)
@objc(MusicKitAuth)
class MusicKitAuth: NSObject {

  @objc(requestAuthorization:withResolver:withRejecter:)
  func requestAuthorization(resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
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

  @objc(getUserToken:withResolver:withRejecter:)
  func getUserToken(resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
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

}
