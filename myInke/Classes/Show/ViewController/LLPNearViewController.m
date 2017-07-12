//
//  LLPNearViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPNearViewController.h"
#import "LLPLiveHandler.h"
#import "LLPNearLiveCell.h"
#import "LLPPlayerViewController.h"

static NSString *identifier = @"LLPNearLiveCell";
static NSInteger kItemWidth = 100;
static NSInteger kMargin = 5;

@interface LLPNearViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray* dataList;

@end

@implementation LLPNearViewController


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLPNearLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}


-(void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LLPNearLiveCell * c = (LLPNearLiveCell*) cell;
    [c showAnimation];
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    LLPLive *live = self.dataList[indexPath.row];
    
    LLPPlayerViewController * playerVc = [[LLPPlayerViewController alloc] init];
    playerVc.live = live;
    
    [self.navigationController pushViewController:playerVc animated:YES];
}


-(CGSize) collectionView:(UICollectionView*) collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSInteger count = self.collectionView.width / kItemWidth;
    
    CGFloat etraWidth = (self.collectionView.width - kMargin * (count +1))/count;
    
    return CGSizeMake(etraWidth, etraWidth+20);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view from its nib.

    
    
    [self initUI];
    [self loadData];
}

-(void) initUI{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LLPNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
}

-(void) loadData{
    
    [LLPLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"%@",obj);
        _dataList = obj;
        
        [self.collectionView reloadData];
        
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
