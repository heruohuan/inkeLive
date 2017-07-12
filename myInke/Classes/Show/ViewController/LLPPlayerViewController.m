//
//  LLPPlayerViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/9.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPPlayerViewController.h"
#import "LLPLiveChatViewController.h"
@interface LLPPlayerViewController ()

@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UIImageView *blurImageView;
@property(nonatomic,strong) LLPLiveChatViewController *liveChatVc;

@end



@implementation LLPPlayerViewController


-(LLPLiveChatViewController*) liveChatVc{
    if (!_liveChatVc) {
        _liveChatVc = [[LLPLiveChatViewController alloc] init];
    }
    return _liveChatVc;
}

-(UIButton*)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        NSLog(@"SCREEN_HEIGHT---->%f",SCREEN_HEIGHT);
        NSLog(@"SCREEN_HEIGHT---->%f",SCREEN_HEIGHT-_closeBtn.height-10);
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width -10, SCREEN_HEIGHT-_closeBtn.height-10, _closeBtn.width, _closeBtn.height);
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(void)closeAction:(UIButton*) btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPlayer];
    
    [self initUI];
    
    [self addChildVC];
}

-(void) initUI{
    self.view.backgroundColor = [UIColor blackColor];
    
    self.blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    if ([self.live.creator.nick isEqualToString:@"hebi"]) {
        [self.blurImageView setImage:[UIImage imageNamed:@"hebi"]];
    }else{
        [self.blurImageView downloadImage:[NSString stringWithFormat:@"%@",self.live.creator.portrait] placeholder:@"default_room"];
    }
    
    [self.view addSubview:self.blurImageView];
    
    //创建毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //创建毛玻璃视图
    UIVisualEffectView *ve = [[UIVisualEffectView alloc] initWithEffect:blur];
    ve.frame = self.blurImageView.bounds;
    [self.blurImageView addSubview:ve];

    
}
-(void) addChildVC{
    
    [self addChildViewController:self.liveChatVc];
    [self.view addSubview:self.liveChatVc.view];
    [self.liveChatVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.liveChatVc setLive:self.live];
    
}
-(void) initPlayer{
    
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.streamAddr withOptions:options];
    
    self.player.view.frame = self.view.bounds;
    
    self.player.shouldAutoplay = YES;
    
    [self.view addSubview:self.player.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //注册直播需要用的通知
    [self installMovieNotificationObservers];
    
    //准备播放
    [self.player prepareToPlay];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self.closeBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[LLPRecordHandler getInstancet] saveLiveTime:self.live];
    
    //关闭直播
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    [self.closeBtn removeFromSuperview];
    
}


- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0, 未知网络
    //    MPMovieLoadStatePlayable       = 1 << 0, 缓冲结束可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
        
        
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}
#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    //监听网络环境，监听缓冲
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}
- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
    
}
#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

@end
