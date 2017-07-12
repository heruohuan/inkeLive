//
//  LLPMainTopView.h
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MainTopBlock)(NSInteger tag);

@interface LLPMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *) titles;

@property(nonatomic,copy) MainTopBlock block;

-(void) scrolling:(NSInteger) tag;

@end
