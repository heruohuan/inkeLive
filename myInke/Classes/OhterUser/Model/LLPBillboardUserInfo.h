//
//  LLPBillboardUserInfo.h
//  myInke
//
//  Created by He_bi on 2017/7/5.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPUserInfo.h"

@interface LLPBillboardUserInfo : NSObject

@property (nonatomic, assign) NSInteger contribution;
@property (nonatomic, assign) NSInteger hide;
@property (nonatomic, strong) LLPUserInfo * user;

@end
