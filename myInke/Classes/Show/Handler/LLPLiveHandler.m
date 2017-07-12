//
//  LLPLiveHandler.m
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPLiveHandler.h"
#import "HttpTool.h"
#import "LLPLive.h"
#import "LLPLocationManager.h"
#import "LLPAdvertise.h"
#import "LLPUserInfo.h"

@implementation LLPLiveHandler

+(void) executeGetHotLiveTaskWithSuccess:(SuccessBlock) success
                                   filed:(FailedBlock)failed{
    
    
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
        
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            
            NSArray *lives = [LLPLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            for (int i = 0; i< lives.count; i++) {
                LLPLive * live = lives[i];
                live.ID = json[@"lives"][i][@"id"];
                live.creator.desc = @"";
                live.creator.idField = [json[@"lives"][i][@"creator"][@"id"] integerValue];
                if ([json[@"lives"][i][@"creator"][@"description"] integerValue]) {
                    live.creator.desc = json[@"lives"][i][@"creator"][@"description"];
                }
            }
            
            success(lives);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


+(void) executeGetHotLiveAllTaskWithSuccess:(SuccessBlock)success filed:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_HotLiveAll params:nil success:^(id json) {
        
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            
            NSArray *lives = [LLPLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            for (int i = 0; i< lives.count; i++) {
                LLPLive * live = lives[i];
                live.ID = json[@"lives"][i][@"id"];
                live.creator.idField = [json[@"lives"][i][@"creator"][@"id"] integerValue];
                live.creator.desc = @"";
                if ([json[@"lives"][i][@"creator"][@"description"] integerValue]) {
                    live.creator.desc = json[@"lives"][i][@"creator"][@"description"];
                }
            }
            
            success(lives);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


+(void) executeGetNearLiveTaskWithSuccess:(SuccessBlock) success
                                    filed:(FailedBlock)failed{
    LLPLocationManager * manager = [LLPLocationManager sharedManager];
    NSDictionary *dic = @{@"uid":@"85149891",@"latitude":manager.lat,@"longitude":manager.lon};
    
    [HttpTool getWithPath:API_NearLive params:dic success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            
            NSArray *lives = [LLPLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

+(void) executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success filed:(FailedBlock)failed{
    
    [HttpTool getWithPath:API_ADvertise params:nil success:^(id json) {
        
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        }else{
            //如果返回数据信息正确
            //数据解析
            
            LLPAdvertise * ad = [LLPAdvertise mj_objectWithKeyValues:json[@"resources"][0]];
            
            success(ad);
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

@end
