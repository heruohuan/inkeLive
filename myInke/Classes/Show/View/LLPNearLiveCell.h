//
//  LLPNearLiveCell.h
//  myInke
//
//  Created by He_bi on 2017/5/23.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPLive.h"
@interface LLPNearLiveCell : UICollectionViewCell

@property(nonatomic,strong)LLPLive *live;

-(void) showAnimation;

@end
