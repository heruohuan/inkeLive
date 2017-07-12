//
//  LLPMainTopView.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPMainTopView.h"

@interface LLPMainTopView ()

@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) NSMutableArray *buttons;

@end

@implementation LLPMainTopView

-(NSMutableArray*) buttons{
    
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}


- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
     
        CGFloat btnWidth = self.width / titles.count;
        CGFloat btnHeight = self.height;
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            //设置按钮文字
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
            
            //设置按钮颜色
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            //设置字体
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            
            titleBtn.frame = CGRectMake(i*btnWidth, 0, btnWidth, btnHeight);
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            titleBtn.tag = i;
            
            [self addSubview:titleBtn];
            
            [self.buttons addObject:titleBtn];
            
            if (i == 1) {
                
                CGFloat h = 2;
                CGFloat y = 40;

                //自适应合适的宽高
                [titleBtn.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc] init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.height = h;
                self.lineView.width = titleBtn.titleLabel.width;
                self.lineView.top = y;
                self.lineView.centerX = titleBtn.centerX;
                
                [self addSubview:self.lineView];
            }
            
        }
        
    }
    return self;
}

//点击调用
-(void) titleClick:(UIButton*) button{
    
    self.block(button.tag);
    //设置动画
    [self scrolling:button.tag];
    
}

//滚动时调用
-(void) scrolling:(NSInteger)tag{
    
    //设置动画
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *btn = self.buttons[tag];
        self.lineView.centerX = btn.centerX;
    }];
    
}


@end
