//
//  LLPMeifoTableViewCell.h
//  myInke
//
//  Created by He_bi on 2017/6/3.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPMeifoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *focusLb;
@property (weak, nonatomic) IBOutlet UILabel *fansLb;
@property (weak, nonatomic) IBOutlet UIButton *descriptionLb;
@property (weak, nonatomic) IBOutlet UIImageView *firstIcon;
@property (weak, nonatomic) IBOutlet UIImageView *secondIcon;
@property (weak, nonatomic) IBOutlet UIImageView *thirdIcon;
@property (weak, nonatomic) IBOutlet UIView *weiboView;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;

@end
