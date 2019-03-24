#import "flutter_oboePlugin.h"
#import <flutter_oboe/flutter_oboe-Swift.h>

@implementation flutter_oboePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [Swiftflutter_oboePlugin registerWithRegistrar:registrar];
}
@end
