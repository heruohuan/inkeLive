//
//  LLPShreListViewCell.m
//  myInke
//
//  Created by He_bi on 2017/7/9.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPShreListViewCell.h"

@implementation LLPShreListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)FeedsInfo:(LLPFeedsInfo *)info{
    
    self.shreDes.text = info.title;
    NSString * str1 = [LLPUtils timestampSwitchTime:[info.ctime integerValue]/1000 andFormatter:@"YYYY年MM月dd日"];
    self.shreTime.text = [LLPUtils timeIntervalFromLastTime:str1 lastTimeFormat:@"YYYY年MM月dd日" ToCurrentTime:[LLPUtils getCurrTimeForStringConversion:@"YYYY年MM月dd日"] currentTimeFormat:@"YYYY年MM月dd日"];
    self.shreLikeNum.text = [LLPUtils getWithThousandsUnitsIsCalculated: [info.likeCount integerValue]];
    self.shareShowCount.text = [NSString stringWithFormat:@"%@ 播放",[LLPUtils getWithThousandsUnitsIsCalculated:[info.viewCount integerValue]]];
    
    
    NSDictionary* dic = [LLPUtils dictionaryWithJsonString:info.content];
    NSLog(@"%@",dic);
    if ([dic objectForKey:@"cover_url"]) {
        [self.shareBg downloadImage:[dic objectForKey:@"cover_url"] placeholder:@"default_room"];
    }
    
    
}

@end
