//
//  LLPTabBar.m
//  myInke
//
//  Created by He_bi on 2017/5/5.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPTabBar.h"

@interface LLPTabBar ()

@property (nonatomic,strong) UIImageView *tabbgView;

@property (nonatomic,strong) NSArray *datalist;

@property (nonatomic,strong) UIButton *lastBtn;

@property (nonatomic,strong) UIButton *cameraButton;

@end


@implementation LLPTabBar

-(UIButton*)cameraButton{
 
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton sizeToFit];
        _cameraButton.tag = LLPItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}


-(UIImageView*) tabbgView{
    
    if (_tabbgView) {
        _tabbgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabbgView;
}

-(NSArray*) datalist{
    
    if (!_datalist) {
        _datalist = @[@"tab_live",@"tab_me"];
    }
    
    return _datalist;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //装载背景
        [self addSubview:_tabbgView];
        
        for (NSInteger i = 0; i<self.datalist.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            //不让图片在高亮下改变
            item.adjustsImageWhenHighlighted = NO;
            
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = LLPItemTypeLive + i;
            
            if (i == 0) {
                item.selected = YES;
                
                self.lastBtn = item;
            }
            
            [self addSubview:item];
        }
        //添加直播按钮
        [self addSubview:self.cameraButton];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    self.tabbgView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width / self.datalist.count;
    
    for (NSInteger i = 0; i<[self subviews].count; i++) {
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.frame = CGRectMake((btn.tag-LLPItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.center.x, self.bounds.size.height-50);
}

-(void) clickItem:(UIButton*) button{
    
    if (button.tag != self.lastBtn.tag) {
        
        // respondsToSelector判断是否实现了某方法
        if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
            [self.delegate tabbar:self clickButton:button.tag];
        }
        
        !self.block?:self.block(self,button.tag);
        
        if (button.tag == LLPItemTypeLaunch) {
            return;
        }
        
        self.lastBtn.selected  = NO;
        button.selected = YES;
        self.lastBtn = button;
        
        //设置动画
        [UIView animateWithDuration:0.2 animations:^{
            //放大
            button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                //恢复原始状态
                button.transform = CGAffineTransformIdentity;
            }];
        }];
    }
    
}



@end
