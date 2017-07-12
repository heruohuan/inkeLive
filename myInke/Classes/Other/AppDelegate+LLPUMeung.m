//
//  AppDelegate+LLPUMeung.m
//  myInke
//
//  Created by He_bi on 2017/5/29.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "AppDelegate+LLPUMeung.h"

@implementation AppDelegate (LLPUMeung)

-(void) setupUMeung{
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57a5581267e58e2557001639"];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@" 3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
