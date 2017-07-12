//
//  LLPShreListViewCell.h
//  myInke
//
//  Created by He_bi on 2017/7/9.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPFeedsInfo.h"

@interface LLPShreListViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *shreDes;
@property (weak, nonatomic) IBOutlet UILabel *shreTime;
@property (weak, nonatomic) IBOutlet UILabel *shreLikeNum;
@property (weak, nonatomic) IBOutlet UIImageView *shareBg;
@property (weak, nonatomic) IBOutlet UILabel *shareShowCount;

-(void)FeedsInfo:(LLPFeedsInfo*)info;

@end
