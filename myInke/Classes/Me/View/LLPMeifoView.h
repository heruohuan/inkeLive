//
//  LLPMeifoView.h
//  myInke
//
//  Created by He_bi on 2017/5/31.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPMeifoView : UIView

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *uidLb;
@property (weak, nonatomic) IBOutlet UILabel *nickLb;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UIImageView *certificationIcon;
@property (weak, nonatomic) IBOutlet UILabel *certificationDes;
@property (weak, nonatomic) IBOutlet UILabel *goldNum;


+(instancetype) loadInfoView;

-(void) changeIconSize:(CGFloat) coefficient;

-(void) changeLeftBtnImage:(UIImage*) image;

-(void) changeRightBtnImage:(UIImage*) image;

@end
