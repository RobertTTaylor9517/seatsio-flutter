#import "SeatsIoFlutterPlugin.h"
#if __has_include(<seats_io_flutter/seats_io_flutter-Swift.h>)
#import <seats_io_flutter/seats_io_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "seats_io_flutter-Swift.h"
#endif

@implementation SeatsIoFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSeatsIoFlutterPlugin registerWithRegistrar:registrar];
}
@end
