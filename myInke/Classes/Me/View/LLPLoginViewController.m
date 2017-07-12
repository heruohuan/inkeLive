//
//  LLPLoginViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/28.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LLPUserHelper.h"
#import "LLPTabBarViewController.h"
@interface LLPLoginViewController ()

@end

@implementation LLPLoginViewController
- (IBAction)sinaLogin:(id)sender {
    
    NSLog(@"登录新浪");
    self.view.window.rootViewController =  [[LLPTabBarViewController alloc] init];
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            
//            // 授权信息
//            NSLog(@"Sina uid: %@", resp.uid);
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.gender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
//        }
//    }];
}
- (IBAction)wechatLogin:(id)sender {
    
    NSLog(@"登录微信");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"登录失败");
        } else {
            NSLog(@"登录成功");
            
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            [LLPUserHelper sharedUser].nickName = resp.name;
            [LLPUserHelper sharedUser].iconUrl = resp.iconurl;
            [LLPUserHelper saveUser];
            
            self.view.window.rootViewController =  [[LLPTabBarViewController alloc] init];
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
