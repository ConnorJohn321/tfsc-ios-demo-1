//
//  AppDelegate.m
//  ExampleForiOS
//
//  Created by Gavery on 2023/11/7.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *svc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    self.window.rootViewController = nav;
    return YES;
}
- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end
