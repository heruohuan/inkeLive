//
//  LLPLiveCell.m
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPLiveCell.h"

@interface LLPLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@end

@implementation LLPLiveCell


-(void) setLive:(LLPLive *)live{
    
    _live = live;
    
    
    self.nameLabel.text = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onLineLabel.text = [@(live.onlineUsers) stringValue];
    if ([live.creator.nick isEqualToString:@"hebi"]) {
        [self.headView setImage:[UIImage imageNamed:@"hebi"]];
        [self.bigImageView setImage:[UIImage imageNamed:@"hebi"]];
    }else{
        [self.headView downloadImage:[NSString stringWithFormat:@"%@",live.creator.portrait] placeholder:@"default_room"];
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@",live.creator.portrait] placeholder:@"default_room"];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置头像为原型
    self.headView.layer.cornerRadius = self.headView.width/2;
    self.headView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
