//
//  LLPAdvertiseView.m
//  myInke
//
//  Created by He_bi on 2017/5/25.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPAdvertiseView.h"
#import "LLPLiveHandler.h"
#import "LLPAdvertise.h"
#import "LLPCacheHelper.h"

static NSUInteger showTime = 3;

@interface LLPAdvertiseView ()

@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) dispatch_source_t timer;

@end

@implementation LLPAdvertiseView



+(instancetype) loadAdvertiseView{

    return [[[NSBundle mainBundle] loadNibNamed:@"LLPAdvertiseView" owner:self options:nil] lastObject];
}

//广告初始化方法
-(void) awakeFromNib{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    
    //展示广告
    [self showAd];
    //下载广告
    [self downAd];
    //倒计时
    [self startTimer];
    

}

-(void) downAd{
    
    [LLPLiveHandler executeGetAdvertiseTaskWithSuccess:^(id obj) {
        
        LLPAdvertise * ad = (LLPAdvertise*)obj;
        
        //SDWebImageAvoidAutoSetImage 下载完不给imageView赋值
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:ad.image] options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                NSLog(@"图片下载成功");
                [LLPCacheHelper setAdvertise:ad.image];
                
            }else{
                NSLog(@"图片下载失败");
            }
        }];
    } filed:^(id obj) {
        NSLog(@"%@",obj);
    }];
    
}

-(void) showAd{
    NSString * fileName = [LLPCacheHelper getAdvertise];
    UIImage * lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromCacheForKey:fileName];
    if (lastCacheImage) {
        self.backView.image = lastCacheImage;
    }else{
        self.hidden = YES;
    }
}

-(void) startTimer{
    
    __block NSUInteger timeOut = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        self.timer = timer;
        if (timeOut<=0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self disappear];
            });
        }else{
            timeOut -- ;
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.timeLabel.text = [NSString stringWithFormat:@"跳过：%zd",timeOut];
            });
        }

    });
    dispatch_resume(timer);
    
}

-(void)disappear{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
