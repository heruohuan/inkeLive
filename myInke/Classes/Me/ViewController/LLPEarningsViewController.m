//
//  LLPEarningsViewController.m
//  myInke
//
//  Created by He_bi on 2017/6/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPEarningsViewController.h"

@interface LLPEarningsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgBottom;

@end

@implementation LLPEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

-(void) updateViewConstraints{
    [super updateViewConstraints];
    NSLog(@"updateViewConstraints");
    self.viewHeight.constant = 1000;
//    self.scrollViewTop.constant = self.view.bounds.size.height *0.1889;
//    self.scrollViewTop.constant = 115.83;
    self.scrollViewTop.constant = (((SCREEN_HEIGHT/667)-1)*(self.scrollViewTop.constant - self.bgTop.constant)+self.scrollViewTop.constant);
    
    self.scrollViewBottom.constant = (((SCREEN_HEIGHT/667)-1)*(self.scrollViewBottom.constant - self.bgBottom.constant)+self.scrollViewBottom.constant);
    NSLog(@"size--------->%f",SCREEN_WIDTH);
    NSLog(@"size--------->%f",SCREEN_HEIGHT);
    
    NSLog(@"size--->%f",self.bg.bounds.size.height);
    NSLog(@"size--->%f",self.bg.bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
