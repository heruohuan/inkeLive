//
//  LLPLiveHandler.h
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPBaseHandler.h"

@interface LLPLiveHandler : LLPBaseHandler


+(void) executeGetHotLiveTaskWithSuccess:(SuccessBlock) success
                                   filed:(FailedBlock)failed;

+(void) executeGetHotLiveAllTaskWithSuccess:(SuccessBlock) success
                                   filed:(FailedBlock)failed;


+(void) executeGetNearLiveTaskWithSuccess:(SuccessBlock) success
                                   filed:(FailedBlock)failed;

+(void) executeGetAdvertiseTaskWithSuccess:(SuccessBlock) success
                                     filed:(FailedBlock)failed;

@end
