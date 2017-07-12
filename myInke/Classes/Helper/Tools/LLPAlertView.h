//
//  LLPAlertView.h
//  myInke
//
//  Created by He_bi on 2017/6/22.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AlertResult)(NSInteger index);

@interface LLPAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

-(instancetype)initWithTitle:(NSString*)title
                     message:(NSString*)message
                     sureBtn:(NSString*)sureTitle
                   cancleBtn:(NSString*)cancleTitle;

-(void)showLLPAlertView;

@end
