//
//  LLPUserHelper.h
//  myInke
//
//  Created by He_bi on 2017/5/29.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPUserHelper : NSObject

@property(nonatomic,copy) NSString *iconUrl;
@property(nonatomic,copy) NSString *nickName;

+(instancetype) sharedUser;

+(BOOL)isAutoLogin;

+(void)saveUser;

@end
