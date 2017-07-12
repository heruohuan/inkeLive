//
//  LLPHotViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPHotViewController.h"
#import "LLPLiveHandler.h"
#import "LLPLiveCell.h"
#import "LLPPlayerViewController.h"
#import "LLPRecordHandler.h"
static NSString *identifier = @"LLPLiveCell";

@interface LLPHotViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSMutableArray *dataList;

@end



@implementation LLPHotViewController

-(NSMutableArray*) dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLPLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LLPLive *live = self.dataList[indexPath.row];
    [[LLPRecordHandler getInstancet] saveLiveTime:live];
    //进入直播间
    LLPPlayerViewController * playerVc = [[LLPPlayerViewController alloc] init];
    playerVc.live = live;
    [self.navigationController pushViewController:playerVc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH + 5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self loadData];
    
}


-(void) initUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LLPLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
}

-(void) loadData{
    
    [LLPLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
       
        NSLog(@"loadData----->%@",obj);
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:obj];
        
        [self.tableView reloadData];
        
        [self loadDataAll];
        [NSTimer scheduledTimerWithTimeInterval:10 block:^(NSTimer * _Nonnull timer) {
            NSLog(@".................");
            [self loadDataAll];
        } repeats:YES];
        
    } filed:^(id obj) {
        
        NSLog(@"%@",obj);
        
    }];
    
}

-(void) loadDataAll{
    
    [LLPLiveHandler executeGetHotLiveAllTaskWithSuccess:^(id obj) {
        
        NSLog(@"loadData----->%@",obj);
        
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:obj];
        
        [self.tableView reloadData];
        
    } filed:^(id obj) {
        
        NSLog(@"%@",obj);
        
    }];
    
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
