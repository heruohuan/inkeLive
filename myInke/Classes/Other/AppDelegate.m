//
//  AppDelegate.m
//  myInke
//
//  Created by He_bi on 2017/5/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "AppDelegate.h"
#import "LLPTabBarViewController.h"
#import "LLPLocationManager.h"
#import "LLPAdvertiseView.h"
#import "LLPLoginViewController.h"
#import "AppDelegate+LLPUMeung.h"
#import "LLPUserHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置状态栏为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setupUMeung];
    [LLPUserHelper sharedUser];
//    if ([LLPUserHelper isAutoLogin]) {
        LLPTabBarViewController *mainVC = [[LLPTabBarViewController alloc] init];
        self.window.rootViewController = mainVC;
//    }else{
//        LLPLoginViewController *mainVC = [[LLPLoginViewController alloc] init];
//        self.window.rootViewController = mainVC;
//    }

    [self.window makeKeyAndVisible];
    
//    [self.window addSubview:[LLPAdvertiseView loadAdvertiseView]];
    
    [[LLPLocationManager sharedManager] getGPS:^(NSString *lat, NSString *lon) {
        NSLog(@"%@",lat);
        NSLog(@"%@",lon);
    }];
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
