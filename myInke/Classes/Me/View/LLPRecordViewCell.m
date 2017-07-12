//
//  LLPRecordViewCell.m
//  myInke
//
//  Created by He_bi on 2017/6/17.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPRecordViewCell.h"

@interface LLPRecordViewCell()

@end

@implementation LLPRecordViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"LLPRecordViewCell" owner:self options:nil] lastObject];
    return self;
}

@end
