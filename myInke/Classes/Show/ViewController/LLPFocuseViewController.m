//
//  LLPFocuseViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPFocuseViewController.h"
#import "LLPLiveCell.h"
#import "LLPPlayerViewController.h"
#import "LLPCreator.h"
static NSString *identifier = @"Focuse";

@interface LLPFocuseViewController ()

@property (nonatomic, strong) NSMutableArray * dataList;

@end

@implementation LLPFocuseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLPLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLPLive *live = self.dataList[indexPath.row];
    
    LLPPlayerViewController * playerVc = [[LLPPlayerViewController alloc] init];
    playerVc.live = live;
    
    [self.navigationController pushViewController:playerVc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH + 5;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(void) initUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LLPLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
}

-(void) loadData{
    
    LLPLive * live = [[LLPLive alloc] init];
    LLPCreator * creator = [[LLPCreator alloc] init];
    live.creator = creator;
    
    live.streamAddr = Live_He_bi;
    live.city = @"上海";
    live.onlineUsers = 62518;
    live.creator.nick = @"hebi";
    [self.dataList addObject:live];
    
}


@end
