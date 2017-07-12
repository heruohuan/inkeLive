//
//  LLPRecordHandler.h
//  myInke
//
//  Created by He_bi on 2017/6/14.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPLive.h"

@interface LLPRecordHandler : NSObject

+(instancetype)getInstancet;

-(void) writeToFile:(NSDictionary*) dic;

-(void) writeToFileForArr:(NSArray*) arr;

-(NSMutableDictionary*) getDataForArray;


-(id) findKeyForString:(NSString*) key;

-(void) saveLiveTime:(LLPLive*) live;

@end
