//
//  LLPCacheHelper.m
//  myInke
//
//  Created by He_bi on 2017/5/25.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPCacheHelper.h"
#define ADIMAGE @"adimage"

@implementation LLPCacheHelper

+(NSString*) getAdvertise{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:ADIMAGE];
}

+(void) setAdvertise:(NSString*) adImage{
    [[NSUserDefaults standardUserDefaults]setObject:adImage forKey:ADIMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
