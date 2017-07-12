//
//  LLPTabBar.h
//  myInke
//
//  Created by He_bi on 2017/5/5.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <UIKit/UIKit.h>

//枚举
typedef NS_ENUM(NSInteger,LLPItemType) {
    LLPItemTypeLaunch = 10,
    LLPItemTypeLive = 100,//展示直播
    LLPItemTypeMe,//我的
};

@class LLPTabBar;

typedef void(^TabBlock)(LLPTabBar*tabbar,LLPItemType idx);


//点击按钮代理
@protocol LLPTabBarDelegate <NSObject>

-(void) tabbar:(LLPTabBar*)tabbar clickButton:(LLPItemType) idx;

@end


@interface LLPTabBar : UIView

@property (nonatomic,weak) id<LLPTabBarDelegate> delegate;

@property (nonatomic,copy) TabBlock block;

@end
