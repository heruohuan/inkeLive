//
//  LLPLaunchViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPLaunchViewController.h"
#import "LFLivePreview.h"

@interface LLPLaunchViewController ()

@end

@implementation LLPLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)startLive:(id)sender {
    
    UIView * blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
    
    
    
    LFLivePreview * preview = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:preview];
    preview.vc = self;
    [preview startLive];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
