//
//  LLPPlayerViewController.h
//  myInke
//
//  Created by He_bi on 2017/5/9.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPBaseViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LLPLive.h"
@interface LLPPlayerViewController : LLPBaseViewController

@property(atomic, retain) id<IJKMediaPlayback> player;

@property(nonatomic,strong) LLPLive *live;

@end
