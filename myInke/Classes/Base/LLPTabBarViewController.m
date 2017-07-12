//
//  LLPTabBarViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/5.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPTabBarViewController.h"
#import "LLPTabBar.h"
#import "LLPBaseNavViewController.h"
#import "LLPLaunchViewController.h"

@interface LLPTabBarViewController ()<LLPTabBarDelegate>

@property (nonatomic,strong) LLPTabBar * llpTabBar;

@end


@implementation LLPTabBarViewController

-(LLPTabBar*) llpTabBar{
    
    if (!_llpTabBar) {
        
        _llpTabBar = [[LLPTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _llpTabBar.delegate = self;
    }
    return _llpTabBar;
    
}

-(void)tabbar:(LLPTabBar *)tabbar clickButton:(LLPItemType)idx{
    
    if (idx != LLPItemTypeLaunch) {
        self.selectedIndex = idx - LLPItemTypeLive;
        return;
    }
    LLPLaunchViewController *launchVC = [[LLPLaunchViewController alloc] init];
    [self presentViewController:launchVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载控制器
    
    [self configViewControllers];
    
    //加载tabbar
    [self.tabBar addSubview:self.llpTabBar];
 
    [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

-(void) configViewControllers{
    
    NSMutableArray *arry = [NSMutableArray arrayWithObjects:@"LLPMainViewController",@"LLPMeViewController", nil];
    
    for (NSInteger i = 0; i<arry.count; i++) {
        NSString *vcName = arry[i];
        
        UIViewController *vc = [[NSClassFromString(vcName)alloc]init];
        LLPBaseNavViewController *nav = [[LLPBaseNavViewController alloc] initWithRootViewController:vc];
        [arry replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = arry;
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
