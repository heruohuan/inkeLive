//
//  LLPOtherUserInfoHandler.m
//  myInke
//
//  Created by He_bi on 2017/7/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPOtherUserInfoHandler.h"
#import "LLPUserInfo.h"
#import "HttpTool.h"
#import "LLPUserImpression.h"
#import "LLPBillboardUserInfo.h"
#import "LLPWeiboInfo.h"
#import "LLPDiamondInfo.h"
#import "LLPFollowInfo.h"
#import "LLPFeedsInfo.h"

@implementation LLPOtherUserInfoHandler

+(void) executeGetOtherUserInfoTaskWithParams:(NSDictionary*)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_UserInfo params:params success:^(id json) {
        NSLog(@"executeGetOtherUserInfoTaskWithParams------->%@",json[@"error_msg"]);
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            LLPUserInfo * user = [LLPUserInfo mj_objectWithKeyValues:json[@"user"]];
            user.descriptionField = json[@"user"][@"description"];
            user.idField = [json[@"user"][@"id"] integerValue];
            success(user);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
    
}

+(void) executeGetOtherUserHomePageInfoTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_UserHomePageInfo params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserHomePageInfoTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
           
        }
        
    } failure:^(NSError *error) {
        
    }];

}

+(void) executeGetOtherUserImpressionTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_UserImpression params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserImpressionTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            NSArray *impressions = [LLPUserImpression mj_objectArrayWithKeyValuesArray:json[@"label_list"]];
            success(impressions);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void) executeGetOtherUserIsLivenTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_UserLiveInfo params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserIsLivenTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            if ( json[@"live"]) {
                
                NSLog(@"");
                success(json[@"live"]);
                
            }else{
                success(NULL);
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void) executeGetOtherUserListTop3TaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_GiveTopThree params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserListTop3TaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            if ( [json[@"count"] integerValue] > 0 ) {
                
                
                NSArray *contributions = [LLPBillboardUserInfo mj_objectArrayWithKeyValuesArray:json[@"contributions"]];
                success(contributions);

                
            }else{
                success(NULL);
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


+(void) executeGetOtherUserWeiboInfoTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_WeiboInfo params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserWeiboInfoTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            if ( json[@"content"]) {
                
                LLPWeiboInfo *weibo = [LLPWeiboInfo mj_objectWithKeyValues:json[@"content"]];
                success(weibo);
            }else{
                success(NULL);
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void) executeGetOtherUserDiamondInfoTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_DiamondsYingPiao params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserDiamondInfoTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            LLPDiamondInfo *diamond = [LLPDiamondInfo mj_objectWithKeyValues:json[@"inout"]];
            success(diamond);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void) executeGetOtherUserFollowInfoTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_AttentionNumberFans params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUserFollowInfoTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            LLPFollowInfo *follow = [LLPFollowInfo mj_objectWithKeyValues:json];
            success(follow);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void) executeGetOtherUseFeedsInfoTaskWithParams:(NSDictionary *)params Success:(SuccessBlock)success filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_UserShreInfo params:params success:^(id json) {
        
        NSLog(@"executeGetOtherUseFeedsInfoTaskWithParams------->%@",json[@"error_msg"]);
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            NSArray *feeds = [LLPFeedsInfo mj_objectArrayWithKeyValuesArray:json[@"feeds"]];
            for (int i = 0; i< feeds.count; i++) {
                LLPFeedsInfo * feed = feeds[i];
                feed.desc = @"";
                if ([feed.desc = json[@"feeds"][i][@"desc"] integerValue]) {
                    feed.desc = json[@"feeds"][i][@"desc"];
                }
                
            }
            success(feeds);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


@end
