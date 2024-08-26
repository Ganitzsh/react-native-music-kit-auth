#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(MusicKitAuth, NSObject)

RCT_EXTERN_METHOD(requestAuthorization:
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(getUserToken:
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
