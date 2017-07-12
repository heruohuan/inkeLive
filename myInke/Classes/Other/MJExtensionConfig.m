//
//  MJExtensionConfig.m
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "LLPCreator.h"
#import "LLPLive.h"
#import "LLPUserImpression.h"
#import "LLPBillboardUserInfo.h"
#import "LLPWeiboInfo.h"
#import "LLPFollowInfo.h"
#import "LLPFeedsInfo.h"
#import "LLPUserInfo.h"

@implementation MJExtensionConfig

+(void) load{
    
    
    [LLPLive mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                    @"ID" : @"id",
                 };
    }];
    
    
    [LLPCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                    @"desc" : @"desciption",
                 };
    }];
    //驼峰转下划线
    [LLPCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];

    [LLPLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LLPUserImpression mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LLPBillboardUserInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LLPWeiboInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LLPFollowInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    [LLPUserInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LLPFeedsInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        if ([propertyName isEqualToString:@"likeCount"]
            ||[propertyName isEqualToString:@"liveId"]
            ||[propertyName isEqualToString:@"topicId"]
            ||[propertyName isEqualToString:@"topicName"]
            ||[propertyName isEqualToString:@"viewCount"]) {
            return propertyName;
        }
        return [propertyName mj_underlineFromCamel];
    }];

}

@end
