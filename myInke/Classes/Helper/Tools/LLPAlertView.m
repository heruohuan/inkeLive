//
//  LLPAlertView.m
//  myInke
//
//  Created by He_bi on 2017/6/22.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPAlertView.h"


///alertView 宽
#define AlertW 268
///各个栏目之间的距离
#define LLPSpace 16.5
#define LLPRadius 8.0
@interface LLPAlertView ()

//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;

@end



@implementation LLPAlertView


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle{
    
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = RGBA(57, 57, 57, 0.0);
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = LLPRadius;
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, 110);
        self.alertView.layer.position = self.center;
        
        
        if (title) {
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*LLPSpace, 2*LLPSpace, AlertW-4*LLPSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*LLPSpace, titleW, titleH);

        }
     
        if (message) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(LLPSpace, CGRectGetMaxY(self.titleLbl.frame)+LLPSpace, AlertW-2*LLPSpace, 20) AndText:message andIsTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            self.msgLbl.textColor = RGB(47, 47, 47);
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+LLPSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*LLPSpace, msgW, msgH);
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.msgLbl?CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*LLPSpace, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+2*LLPSpace, AlertW, 1);
        self.lineView.backgroundColor = RGB(247, 247, 247);
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            
            [self.cancleBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:RGB(47, 47, 47) forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(LLPRadius, LLPRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && sureTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = RGB(247, 247, 247);
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:RGB(0, 216, 201) forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(LLPRadius, LLPRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:RGB(47, 47, 47) forState:UIControlStateNormal];
            self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(LLPRadius, LLPRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[LLPUtils createImageWithColor:RGBA(255, 255, 255, 0.2)] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [self.sureBtn setTitleColor:RGB(0, 216, 201) forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(LLPRadius, LLPRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        
        [self addSubview:self.alertView];
    }
    
    return self;
}


#pragma mark - 弹出 -
- (void)showLLPAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(1.20, 1.20);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.backgroundColor = RGBA(57, 57, 57, 0.4);
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark - 回调 -设置只有2 -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
    if (sender.tag == 2) {
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
    }
    [self removeFromSuperview];
}


-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}
@end
