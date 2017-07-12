//
//  LLPMainViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPMainViewController.h"
#import "LLPMainTopView.h"

@interface LLPMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) LLPMainTopView *topView;

@end

@implementation LLPMainViewController


-(LLPMainTopView*) topView{
    if (!_topView) {
        _topView = [[LLPMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
        
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag*SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
        };
        
    }
    return _topView;
}


-(NSArray*) dataList{
    
    if (!_dataList) {
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void) initUI{

    //添加左右按钮
    [self setupNav];
    
    //添加子视图控制器
    [self setupChildViewControllers];
}

-(void) setupChildViewControllers{
    
    NSArray * vcNames = @[@"LLPFocuseViewController",@"LLPHotViewController",@"LLPNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.dataList[i];
        
        //当执行addChildViewController时，不会执行Vc的ViewDidLoad
        [self addChildViewController:vc];
    }
    
    //将子视图控制器的View，加到MainVC的ScrollView上
    //设置ScrollView的contentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    
    //默认展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

-(void) setupNav{
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}


//动画结束调用代理
-(void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //获取索引值
    NSInteger idx = offsetX / width;
    
    [self.topView scrolling:idx];
    
    //根据索引值返回VC引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判断当前VC是否执行过ViewdidLoad
    if ([vc isViewLoaded]) return;
    
    //设置自控制器view的大小
    vc.view.frame = CGRectMake(offsetX, 0, scrollView.frame.size.width, height);
    
    //将子控制器的view加入ScrollView上
    [scrollView addSubview:vc.view];
}


//减速结束时调用加载子视图控制器的view的方法
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    [self scrollViewDidEndScrollingAnimation:scrollView];
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
