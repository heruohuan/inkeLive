//
//  LLPBaseHandler.h
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>



//处理完成事件
typedef void(^CompleteBlock)();
//处理事件成功
typedef void(^SuccessBlock)(id obj);
//处理事件失败
typedef void(^FailedBlock)(id obj);

@interface LLPBaseHandler : NSObject



@end
