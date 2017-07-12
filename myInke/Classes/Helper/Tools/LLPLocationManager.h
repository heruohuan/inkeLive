//
//  LLPLocationManager.h
//  myInke
//
//  Created by He_bi on 2017/5/12.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlock)(NSString *lat,NSString* lon);
@interface LLPLocationManager : NSObject

+(instancetype) sharedManager;

-(void)getGPS:(LocationBlock) block;

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;

@end
