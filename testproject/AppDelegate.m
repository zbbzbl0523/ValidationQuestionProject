//
//  AppDelegate.m
//  testproject
//
//  Created by bolang on 2020/5/25.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建UIWindow对象，并初始化该窗口的大小与主屏幕大小相同
    CGRect rect = [[UIScreen mainScreen] bounds];
    // 程序将创建的UIWindow对象赋值给该程序委托对象的window属性
    self.window = [[UIWindow alloc] initWithFrame:rect];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

// 此方法已过期了
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    if ([sourceApplication isEqualToString:@"com.apple.mobilesafari"]) {
        return NO;
    }
    return YES;
}


@end
