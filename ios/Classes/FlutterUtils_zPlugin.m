#import "FlutterUtils_zPlugin.h"
#import <flutter_utils_z/flutter_utils_z-Swift.h>

@implementation FlutterUtils_zPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUtils_zPlugin registerWithRegistrar:registrar];
}
@end
