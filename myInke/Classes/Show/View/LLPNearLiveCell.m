//
//  LLPNearLiveCell.m
//  myInke
//
//  Created by He_bi on 2017/5/23.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPNearLiveCell.h"


@interface LLPNearLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation LLPNearLiveCell

-(void)setLive:(LLPLive *)live{
    _live = live;
    
    [self.headView downloadImage:live.creator.portrait placeholder:@"default_room"];
    
    self.distanceLabel.text = live.distance;
}

-(void) showAnimation{
    if (!self.live.show) {
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        [UIView animateWithDuration:0.5 animations:^{
            self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            self.live.show = YES;
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
