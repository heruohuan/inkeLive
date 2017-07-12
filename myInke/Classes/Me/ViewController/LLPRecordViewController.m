//
//  LLPRecordViewController.m
//  myInke
//
//  Created by He_bi on 2017/6/4.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPRecordViewController.h"
#import "LLPRecordViewCell.h"
#import "LLPLiveHandler.h"
#import "LLPUserInfo.h"
#import "LLPOtherUserInfoHandler.h"
#import "LLPUserInofoViewController.h"

static NSString *identifier = @"LLPRecordViewCell";

@interface LLPRecordViewController ()

@property (nonatomic,strong) NSMutableDictionary * dataList;
@property (nonatomic,strong) NSMutableArray * sortedArray;
@property (nonatomic,copy) NSString* currTime;

@end

@implementation LLPRecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    self.currTime = [LLPUtils getCurrTimeForStringConversion:@"YYYYMMdd"];

    [self loadData];
    
    [self initUI];
    
}

-(void) loadData{
    
    self.dataList = [[LLPRecordHandler getInstancet] getDataForArray];
    self.sortedArray = [[[self.dataList allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj2 compare:obj1 options:NSNumericSearch];
    }] mutableCopy];
    NSLog(@".....%@",self.dataList);
    NSLog(@".....%@",self.sortedArray);

    for (id key in self.dataList){
        for (id value in [self.dataList objectForKey:key]) {
            NSDictionary * dic  = [NSDictionary dictionaryWithObject:[value objectForKey:@"ID"] forKey:@"id"];
            [LLPOtherUserInfoHandler executeGetOtherUserInfoTaskWithParams:dic Success:^(id obj) {
                LLPUserInfo * user = (LLPUserInfo*)obj;
                if (user.idField == [[value objectForKey:@"ID"] integerValue]) {
                    [value setObject:user.descriptionField forKey:@"desc"];
                    [value setObject:user forKey:@"userInfo"];
                    [self.tableView reloadData];
                }
            } filed:^(id obj) {
                
            }];
            
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return self.dataList.count;
    
}
-(void) initUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LLPRecordViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    UIView* vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    vc.backgroundColor = RGB(247, 247, 247);
    vc.clipsToBounds = YES;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0,30)];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0,CGFLOAT_MIN)];
    self.tableView.backgroundView = vc;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    //设置分割线颜色
    [self.tableView setSeparatorColor:RGBA(207, 207, 207,0.6)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部清空"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self action:@selector(removeAllRecords)];

    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithWhite:240 alpha:0.7]];
    
    if (self.dataList.count == 0) {
        [self showEmptyDataUI];
    }
    
}

-(void) removeAllRecords{
    LLPAlertView *alerView = [[LLPAlertView alloc] initWithTitle:nil
                                                         message:@"清空后会删除所有的历史观看记录，确认清空么？"
                                                         sureBtn:@"清空"
                                                       cancleBtn:@"取消"];
    alerView.resultIndex = ^(NSInteger index) {
        
        if (self.dataList.count>0) {
            [self.dataList removeAllObjects];
            [self.tableView reloadData];
            [self showEmptyDataUI];
        }
    };
    [alerView showLLPAlertView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger index = 0;
    for (id key in self.dataList){
        if (section == index) {
            NSMutableArray* r = [self.dataList objectForKey:self.sortedArray[index]];
            return r.count;
        }
        index++;
    }
    return 0;

}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSInteger index = 0;
    for (id key in self.dataList){
        if (section == index) {
            if ([self.sortedArray[index] isEqualToString:self.currTime]) {
                return @"今天";
            }else{
                NSString * time = [LLPUtils timeFormatConversionTime:self.sortedArray[index]
                                                      currConversion:@"YYYYMMdd"
                                                        toConversion:@"YYYY-MM-dd"];
                return time;
            }
        }
        index++;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLPRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.nike.text = [self getDataForMutableDic:indexPath.section :indexPath.row :@"nick"];
    cell.desc.text = [self getDataForMutableDic:indexPath.section :indexPath.row :@"desc"];
    [cell.iconImage downloadImage:[self getDataForMutableDic:indexPath.section :indexPath.row :@"iconUrl"] placeholder:@"default_room"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//单元格显示效果协议
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCellEditingStyleInsert
    //UITableViewCellEditingStyleDelete
    //UITableViewCellEditingStyleNone
//    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete;
}

//可以显示编辑状态，当手指在单元格上移动时
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* key = self.sortedArray[indexPath.section];
    NSMutableArray *array = [self.dataList objectForKey:key];
    if (array) {
        [array removeObjectAtIndex:indexPath.row];
        if (array.count==0) {
            [self.dataList removeObjectForKey:key];
            [self.sortedArray removeObjectAtIndex:indexPath.section];
            if (self.dataList.count == 0) {
                [self showEmptyDataUI];
            }
        }
    }
    [self.tableView reloadData];
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选择---->indexPath.section:%d",(int)indexPath.section);
    NSLog(@"选择---->indexPath.row:%d",(int)indexPath.row);
    
    LLPUserInofoViewController * vc = [[LLPUserInofoViewController alloc]
    init];
    [vc userInfoData:[self getDataForMutableDic:indexPath.section :indexPath.row :@"userInfo"]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (id) getDataForMutableDic:(NSInteger) section :(NSInteger) row :(NSString*)keyword{
    
    NSInteger index = 0;
    for (id key in self.dataList){
        if (section == index) {
            NSMutableArray* r = [self.dataList objectForKey:self.sortedArray[index]];
            return [r[row] objectForKey:keyword];
        }
        index++;
    }
    return @"";
}

-(void)showEmptyDataUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iksv_empty_video"]];
    [self.tableView.backgroundView addSubview:imageView];
    [imageView autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self.tableView.backgroundView];
    [imageView autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:self.tableView.backgroundView withOffset:-70];
    
    UILabel *labelDes = [[UILabel alloc] init];
    labelDes.text = @"你最近没有观看任何直播";
    labelDes.font = [UIFont systemFontOfSize:13];
    labelDes.textColor = RGBA(130, 130, 130, 0.8);
    labelDes.textAlignment = NSTextAlignmentCenter;
    [self.tableView.backgroundView addSubview:labelDes];
    [labelDes autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [labelDes autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [labelDes autoSetDimension:ALDimensionHeight toSize:25];
    [labelDes autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:5.0f];
}
@end
