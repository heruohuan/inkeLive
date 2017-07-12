//
//  LLPOtherUserInfoHandler.h
//  myInke
//
//  Created by He_bi on 2017/7/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPBaseHandler.h"

@interface LLPOtherUserInfoHandler : LLPBaseHandler

//获取其他用户信息
+(void) executeGetOtherUserInfoTaskWithParams:(NSDictionary*)params
                                  Success:(SuccessBlock) success
                                    filed:(FailedBlock)failed;
//获取其他用户的主页信息
+(void) executeGetOtherUserHomePageInfoTaskWithParams:(NSDictionary*)params
                                      Success:(SuccessBlock) success
                                        filed:(FailedBlock)failed;

//获取用户的印象
+(void) executeGetOtherUserImpressionTaskWithParams:(NSDictionary*)params
                                              Success:(SuccessBlock) success
                                                filed:(FailedBlock)failed;

//获取用户是否处于直播状态及直播信息
+(void) executeGetOtherUserIsLivenTaskWithParams:(NSDictionary*)params
                                            Success:(SuccessBlock) success
                                              filed:(FailedBlock)failed;

//获取该用户奉献榜单前三名
+(void) executeGetOtherUserListTop3TaskWithParams:(NSDictionary*)params
                                         Success:(SuccessBlock) success
                                           filed:(FailedBlock)failed;

//获取该用户微博信息
+(void) executeGetOtherUserWeiboInfoTaskWithParams:(NSDictionary*)params
                                          Success:(SuccessBlock) success
                                            filed:(FailedBlock)failed;

//获取该用户的钻石映票数量
+(void) executeGetOtherUserDiamondInfoTaskWithParams:(NSDictionary*)params
                                           Success:(SuccessBlock) success
                                             filed:(FailedBlock)failed;

//获取该用户的粉丝和关注
+(void) executeGetOtherUserFollowInfoTaskWithParams:(NSDictionary*)params
                                             Success:(SuccessBlock) success
                                               filed:(FailedBlock)failed;


//获取该用户的社交信息
+(void) executeGetOtherUseFeedsInfoTaskWithParams:(NSDictionary*)params
                                            Success:(SuccessBlock) success
                                              filed:(FailedBlock)failed;
@end
