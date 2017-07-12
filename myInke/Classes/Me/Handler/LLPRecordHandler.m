//
//  LLPRecordHandler.m
//  myInke
//
//  Created by He_bi on 2017/6/14.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPRecordHandler.h"

static NSString* fileName = @"record.plist";
static NSString* filePath = NULL;
@implementation LLPRecordHandler


+(instancetype)getInstancet{
    static LLPRecordHandler * recordHandler;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        recordHandler = [[LLPRecordHandler alloc] init];
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        filePath = [path stringByAppendingPathComponent:fileName];
        NSLog(@"filePath---->%@",filePath);
        
    });
    return recordHandler;
}

-(void) writeToFile:(id) dic{
    if (filePath) {
        NSDictionary * writeDic = dic;
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            NSLog(@"-------文件存在，追加文件----------");
            
            NSDictionary * oldDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
            for (id key in dic) {
                [oldDic setValue:[dic objectForKey:key] forKey:key];
            }
            writeDic = oldDic;
        }
        
        if ([writeDic writeToFile:filePath atomically:YES]) {
             NSLog(@"------写入文件------success");
        }else{
            
            NSLog(@"------写入文件------fail,error");
        }
    
    }
}

-(void) writeToFileForArr:(NSArray *)arr{
    if (filePath) {
        NSMutableArray * writeArr = [arr mutableCopy];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSLog(@"-------文件存在，追加文件----------");
            NSArray * oldArr = [NSArray arrayWithContentsOfFile:filePath];
            for (id value in oldArr) {
                if ([[value objectForKey:@"ID"] isEqualToString:[arr[0] objectForKey:@"ID"]]) {
                    return;
                }else{
                    [writeArr addObject:value];
                }
            }
        }
        
        if ([writeArr writeToFile:filePath atomically:YES]) {
            NSLog(@"------写入文件------success");
        }else{
            NSLog(@"------写入文件------fail,error");
        }
        
    }
}

-(id)findKeyForString:(NSString *)key{
    if (filePath) {
       NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        return dic;
    }
    return NULL;
}

-(void) saveLiveTime:(LLPLive *)live{
    
    NSDictionary * dic = @{live.ID:@{@"nick":live.creator.nick,
                                     @"desc":live.creator.desc,
                                     @"ID":[NSString stringWithFormat:@"%ld",live.creator.idField],
                                     @"sex":[NSString stringWithFormat:@"%ld",live.creator.sex],
                                     @"iconUrl":[NSString stringWithFormat:@"%@",live.creator.portrait],
                                     @"openTime":[NSString stringWithFormat:@"%@",[LLPUtils getCurrTimeForStringConversion:@"YYYY-MM-dd HH:mm:ss"]]}};
    [[LLPRecordHandler getInstancet] writeToFile:dic];
    
}

-(NSMutableDictionary*) getDataForArray{
    NSMutableArray * todayArr = [NSMutableArray array];
    NSMutableDictionary * dicData = [NSMutableDictionary dictionary];
    NSMutableDictionary * otherDic = [NSMutableDictionary dictionary];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString* currTime = [LLPUtils getCurrTimeForStringConversion:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString* currTimeShort = [LLPUtils timeFormatConversionTime:currTime
                                                  currConversion:@"YYYY-MM-dd HH:mm:ss"
                                                    toConversion:@"YYYYMMdd"];
    for (id key in dic) {
        
        NSString* last = [[dic objectForKey:key] objectForKey:@"openTime"];
        NSString* interval = [LLPUtils timeIntervalFromLastTime:last lastTimeFormat:@"YYYY-MM-dd HH:mm:ss"
                                                  ToCurrentTime:currTime currentTimeFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSLog(@"interval---------->%@",interval);

        NSString* lastTimeShort = [LLPUtils timeFormatConversionTime:last
                                                      currConversion:@"YYYY-MM-dd HH:mm:ss"
                                                        toConversion:@"YYYYMMdd"];
        if ([currTimeShort isEqualToString:lastTimeShort]) {
            [todayArr addObject:[dic objectForKey:key]];
        }else{
            NSString * time = [LLPUtils timeFormatConversionTime:last
                                                  currConversion:@"YYYY-MM-dd HH:mm:ss"
                                                    toConversion:@"YYYYMMdd"];
            
            if ([[otherDic allKeys] containsObject:time]) {
                [[otherDic objectForKey:time] addObject:[dic objectForKey:key]];
                
            }else{
                NSMutableArray * otherArr = [NSMutableArray array];
                [otherArr addObject:[dic objectForKey:key]];
                [otherDic setObject:otherArr forKey:time];
                
            }
        }
        
    }
    
    if (todayArr.count >0) {
        [dicData setObject:todayArr forKey:[LLPUtils getCurrTimeForStringConversion:@"YYYYMMdd"]];
    }
    if (otherDic.count > 0) {
        for (id key in otherDic) {
            [dicData setObject:[otherDic objectForKey:key] forKey:key];
        }
        [otherDic removeAllObjects];
    }
    
    return dicData;
}



@end
