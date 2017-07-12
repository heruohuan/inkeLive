//
//  LLPMeViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/31.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPMeViewController.h"
#import "LLPMeifoView.h"
#import "LLPSetting.h"
#import "LLPMeifoTableViewCell.h"

#define BGHEIGHT SCREEN_WIDTH*0.87
static NSString *identifier = @"LLPMeifoTableViewCell";

@interface LLPMeViewController ()
@property (nonatomic,strong) NSMutableArray * dataList;
@property (nonatomic,strong) LLPMeifoView * infoView;
@property (nonatomic,strong) UINib *nib;
@property (nonatomic,strong) UIViewController * currVC;
@property (nonatomic,strong) UIImageView * imageVC;
@end



@implementation LLPMeViewController

-(void)viewWillAppear:(BOOL)animated{
    //使用动画 完美过渡
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    //使用动画 完美过渡
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


-(LLPMeifoView*) infoView{
    if (!_infoView) {
        _infoView = [[LLPMeifoView alloc] init];
        NSLog(@"SCREEN_WIDTH----->%f",SCREEN_WIDTH);
        _infoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, BGHEIGHT);
    }
    return _infoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self initUI];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 60;
    self.tableView.sectionFooterHeight = 7;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer * _Nonnull timer) {
    self.tableView.tableHeaderView = self.infoView;
    
    //滑动列表，顶部头像的拉伸[backgroundView]
    self.tableView.backgroundView = [[UIView alloc] init];
    self.imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,BGHEIGHT)];
    self.imageVC.contentMode = UIViewContentModeScaleAspectFill;
    self.imageVC.image = [UIImage imageNamed:@"xiaoxiao2"];
    self.imageVC.clipsToBounds = YES;
    [self.tableView.backgroundView addSubview:self.imageVC];

    } repeats:NO];

    //设置分割线颜色
    [self.tableView setSeparatorColor:RGBA(207, 207, 207,0.6)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void) loadData{
    
    LLPSetting * set1 = [[LLPSetting alloc] init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.iconName = @"home_account_icon";
    set1.vcName = @"LLPGongViewController";

    LLPSetting * set21 = [[LLPSetting alloc] init];
    set21.title = @"视频";
    set21.subTitle = @"";
    set21.iconName = @"home_video_icon";
    set21.vcName = @"LLPVideoViewController";
    
    LLPSetting * set22 = [[LLPSetting alloc] init];
    set22.title = @"观看记录";
    set22.subTitle = @"";
    set22.iconName = @"home_watch_record_icon";
    set22.vcName = @"LLPRecordViewController";
    
    LLPSetting * set2 = [[LLPSetting alloc] init];
    set2.title = @"收益";
    set2.subTitle = @"8273492 映票";
    set2.iconName = @"home_harvest_icon";
    set2.vcName = @"LLPEarningsViewController";

    
    LLPSetting * set3 = [[LLPSetting alloc] init];
    set3.title = @"账户";
    set3.subTitle = @"82763 钻石";
    set3.iconName = @"home_account_icon";
    set3.vcName = @"LLPAccountViewController";

    
    LLPSetting * set4 = [[LLPSetting alloc] init];
    set4.title = @"等级";
    set4.subTitle = @"66 级";
    set4.iconName = @"home_level_icon";
    set4.vcName = @"LLPLevelViewController";
    
    LLPSetting * set41 = [[LLPSetting alloc] init];
    set41.title = @"实名认证";
    set41.subTitle = @"";
    set41.iconName = @"home_invite_friend_icon";
    set41.vcName = @"LLPApproveViewController";
    
    LLPSetting * set5 = [[LLPSetting alloc] init];
    set5.title = @"设置";
    set5.subTitle = @"";
    set5.iconName = @"home_setting_icon";
    set5.vcName = @"LLPSettingViewController";

    NSArray * arr1 = @[@""];
    
    NSArray * arr2 = @[set21,set22,set2,set3,set4,set41];

    NSArray * arr3 = @[set5];
    
    self.dataList = [@[arr1,arr2,arr3] mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray * arr = self.dataList[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    if (indexPath.section == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            [self.tableView registerNib:[UINib nibWithNibName:@"LLPMeifoTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
            LLPMeifoTableViewCell* meCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            meCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return meCell;
        }
        return cell;
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    LLPSetting * set = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = set.title;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = set.subTitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.detailTextLabel.textColor = RGB(255, 193,37);
    }
    cell.imageView.image = [UIImage imageNamed:set.iconName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return self.infoView;
//    }
//    
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 140;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        LLPSetting * set = self.dataList[indexPath.section][indexPath.row];
        UIViewController *vc = [[NSClassFromString(set.vcName)alloc]init];
        vc.title = set.title;
        self.currVC = vc;
        [self jumpTargetController:vc];
    }
}

-(void)jumpTargetController:(UIViewController*) vc{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    __weak typeof(self) _self = self;
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //将当前的根视图控制器弹出，返回到上一级别
        [_self.currVC.navigationController popViewControllerAnimated:YES];
        NSLog(@"返回");
    }];
    [btn setBackgroundImage:[UIImage imageNamed:@"iksv_publish_back"] forState:UIControlStateNormal];
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;  //偏移距离  -向左偏移, +向右偏移
    vc.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,btn_left,nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffSet = scrollView.contentOffset.y;
    CGRect oldFream = self.imageVC.frame;
    if(contentOffSet <=BGHEIGHT){
        oldFream.size.height = BGHEIGHT-contentOffSet;
        self.imageVC.frame = oldFream;
    }
}

@end
