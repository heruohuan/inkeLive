//
//  LLPUserHelper.m
//  myInke
//
//  Created by He_bi on 2017/5/29.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPUserHelper.h"

@implementation LLPUserHelper

+(instancetype) sharedUser{
    
    static LLPUserHelper * _user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[LLPUserHelper alloc] init];
    });
    return _user;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _iconUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconUrl"];
        _nickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
        
    }
    return self;
}

+(BOOL)isAutoLogin{
 
    if ([LLPUserHelper sharedUser].nickName.length == 0) {
        
        return NO;
    }else{
        
        return YES;
    }
}

+(void)saveUser{
    
    LLPUserHelper * user = [LLPUserHelper sharedUser];
    if (user.nickName.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"nickName" forKey:user.nickName];
        [[NSUserDefaults standardUserDefaults] setObject:@"iconUrl" forKey:user.iconUrl];
    }
    
}

@end
