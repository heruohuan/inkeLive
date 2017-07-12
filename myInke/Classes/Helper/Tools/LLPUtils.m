//
//  LLPUtils.m
//  myInke
//
//  Created by He_bi on 2017/6/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPUtils.h"

@implementation LLPUtils

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 * 计算上次日期距离现在多久
 *
 * @param lastTime  上次日期(需要和格式对应)
 * @param format1   上次日期格式
 * @param currentTime 最近日期(需要和格式对应)
 * @param format2   最近日期格式
 *
 * @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [LLPUtils timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}


+ (NSString *)getCurrTimeForStringConversion:(NSString*) conversion{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:conversion];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;   
}
+(NSString*) timeFormatConversionTime:(NSString *)time currConversion:(NSString *)conversion toConversion:(NSString *)toConversion{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = conversion;
    NSDate *lastDate = [[dateFormatter1 dateFromString:time]
                        dateByAddingTimeInterval:[timeZone
                                                  secondsFromGMTForDate:[dateFormatter1
                                                                         dateFromString:time]]];
    
    NSDateFormatter * df =[[NSDateFormatter alloc]init];
    df.dateFormat = toConversion;
    NSString * lastTime = [df stringFromDate:lastDate];
    return lastTime;
}

+(NSString*) getCompletePictureLinks:(NSString *)links{
    
    NSRange foundObj=[links rangeOfString:@"img2.inke.cn" options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        return links;
    } else {
        return [NSString stringWithFormat:@"http://img2.inke.cn/%@",links];
    }
}

+(NSString*) getCompletePictureLinks:(NSString *)links widht:(NSInteger)widht Height:(NSInteger)height{
    NSRange foundObj=[links rangeOfString:@"img2.inke.cn" options:NSCaseInsensitiveSearch];
    if(foundObj.length==0) {
        links =  [NSString stringWithFormat:@"http://img2.inke.cn/%@",links];
    }
    links =  [NSString stringWithFormat:@"%@url=%@&w=%d&=%d%s",API_ImageScale,links,(int)widht,(int)height,"&s=0&c=0&o=0"];
    return links;
}

+(NSString *) getDigitalEllipsisDisplay:(NSInteger)num{
    if (num > 10000) {
        float results =  (float)num/10000;
        float fValue = round(results*10)/10;
        return [NSString stringWithFormat:@"%.1f万",fValue];
    }
    return [NSString stringWithFormat:@"%d",(int)num];
}

+(NSString *) getWithThousandsUnitsIsCalculated:(NSInteger)num{
    if (num >= 1000) {
        float results =  (float)num/1000;
        if (results>=10) {
            results = results/10;
            float fValue = round(results*10)/10;
            return [NSString stringWithFormat:@"%.1fW",fValue];
        }else{
            float fValue = round(results*10)/10;
            return [NSString stringWithFormat:@"%.1fK",fValue];
        }
        
    }
    return [NSString stringWithFormat:@"%d",(int)num];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591 = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}
@end
