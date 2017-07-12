//
//  LLPMeifoView.m
//  myInke
//
//  Created by He_bi on 2017/5/31.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPMeifoView.h"

@interface LLPMeifoView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *bigBg;

@end

@implementation LLPMeifoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) loadInfoView{

    
    return [[[NSBundle mainBundle] loadNibNamed:@"LLPMeifoView" owner:self options:nil] lastObject];
}

- (instancetype)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"LLPMeifoView" owner:self options:nil] lastObject];
    if (self) {
        //设置图片为圆角
        self.iconView.layer.cornerRadius = 30;
        self.iconView.layer.masksToBounds = YES;
    }
    return self;
}


-(void) changeIconSize:(CGFloat)coefficient{
    
    NSLog(@"----->%f",coefficient);
    NSLog(@"----->%f",SCREEN_WIDTH);
//    [self.iconView setContentScaleFactor:2];
    
//    CGRect rect = self.frame;
//    rect.origin.y = coefficient;
//    rect.size.height = CGRectGetHeight(rect) - coefficient;
//    self.iconView.frame = rect;
//    self.clipsToBounds = YES;
//
//    CGFloat width = self.frame.size.width;    //图片宽度
//     //偏移量
//    CGFloat totalOffset = 150 + fabs(coefficient);
//    CGFloat f = totalOffset / 150; //缩放系数
//    self.bigBg.frame = CGRectMake(-(f * width - width) / 2, coefficient, width * f, totalOffset);
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat yOffset = coefficient  ;
//    if (yOffset < 0) {
//        CGFloat totalOffset = 300 + ABS(yOffset);
//        CGFloat f = totalOffset / 300;
//        self.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
//    }
    
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH*0.73)-coefficient);
}


-(void) changeImageWithBtn:(UIButton *)btn Image:(UIImage*)iamge{

    [btn setImage:iamge forState:UIControlStateNormal];
    
}

-(void) changeLeftBtnImage:(UIImage *)image
{
    [self changeImageWithBtn:self.leftBtn Image:image];
}

-(void) changeRightBtnImage:(UIImage *)image{
    [self changeImageWithBtn:self.rightBtn Image:image];
}






@end
