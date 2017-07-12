//
//  LLPUtils.h
//  myInke
//
//  Created by He_bi on 2017/6/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPUtils : NSObject

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

+ (UIImage*) createImageWithColor:(UIColor*) color;

//时间差计算
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;
+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime;

//时间格式转换
+ (NSString *)timeFormatConversionTime:(NSString *)time
                        currConversion:(NSString*)conversion
                          toConversion:(NSString*)toConversion;

//获取当前时间
+ (NSString *)getCurrTimeForStringConversion:(NSString*) conversion;

//将时间戳转换为标准时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

//获取图片的完整地址
+ (NSString *)getCompletePictureLinks:(NSString*) links;

+ (NSString *)getCompletePictureLinks:(NSString*) links widht:(NSInteger)widht Height:(NSInteger)height;

//以万单位计算
+ (NSString *)getDigitalEllipsisDisplay:(NSInteger) num;

//以千单位计算
+ (NSString *)getWithThousandsUnitsIsCalculated:(NSInteger) num;

//json字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转换成json字符串
+ (NSString*)convertToJSONData:(id)infoDict;

@end
