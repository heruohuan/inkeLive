//
//  LLPUserInofoViewController.m
//  myInke
//
//  Created by He_bi on 2017/7/2.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPUserInofoViewController.h"
#import "LLPMeifoView.h"
#import "LLPMeifoTableViewCell.h"
#import "LLPOtherUserInfoHandler.h"
#import "LLPBillboardUserInfo.h"
#import "LLPFollowInfo.h"
#import "LLPShreListViewCell.h"
#import "LLPFeedsInfo.h"


#define BGHEIGHT SCREEN_WIDTH*0.87
static NSString *identifier = @"LLPMeifoTableViewCell";
static NSString *identifier2 = @"LLPShreListViewCell";

@interface LLPUserInofoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray * dataList;
@property (nonatomic,strong) LLPMeifoView * infoView;
@property (nonatomic,strong) LLPMeifoTableViewCell * infoViewCell;
@property (nonatomic,strong) UIImageView * imageVC;
@property (nonatomic,strong) LLPUserInfo* infoData;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,assign) NSInteger collectionHeight;

@end

@implementation LLPUserInofoViewController


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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(LLPMeifoView*) infoView{
    if (!_infoView) {
        _infoView = [[LLPMeifoView alloc] init];
        NSLog(@"SCREEN_WIDTH----->%f",SCREEN_WIDTH);
        _infoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, BGHEIGHT);
        [_infoView changeLeftBtnImage:[UIImage imageNamed:@"iksv_publish_back"]];
        [_infoView changeRightBtnImage:[UIImage imageNamed:@"more_icon"]];
        _infoView.uidLb.text = [NSString stringWithFormat:@"%ld",self.infoData.liverank.uid];
        _infoView.location.text = self.infoData.hometown;
        _infoView.nickLb.text = self.infoData.nick;
        if (![self.infoData.verifiedReason isEqualToString:@""]) {
            _infoView.certificationDes.text = self.infoData.verifiedReason;
        }else{
            _infoView.certificationIcon.hidden = YES;
            _infoView.certificationDes.hidden = YES;
        }
        if (self.infoData.sex == 1) {
            _infoView.sexImage.image = [UIImage imageNamed:@"global_male"];
        }
        [_infoView.leftBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        

    }
    return _infoView;
}

-(LLPMeifoTableViewCell*)infoViewCell{
    if (!_infoViewCell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"LLPMeifoTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _infoViewCell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        _infoViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _infoViewCell.weiboView.hidden = YES;
        _infoViewCell.descriptionLb.enabled = NO;
        NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",(int)self.infoData.idField],@"id",
                              USER_ID,@"uid",
                              SID,@"sid",nil];
        
        [LLPOtherUserInfoHandler executeGetOtherUserWeiboInfoTaskWithParams:dic1 Success:^(id obj) {
            _infoViewCell.weiboView.hidden = NO;
            [_infoViewCell.weiboBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                NSLog(@"打开微博......");
            }];
        } filed:^(id obj) {
            
            
        }];
        
        //前三名头像设置
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"3",@"count",
                          [NSString stringWithFormat:@"%d",(int)self.infoData.idField],@"id",
                          USER_ID,@"uid",
                          SID,@"sid",nil];

        [LLPOtherUserInfoHandler executeGetOtherUserListTop3TaskWithParams:dic Success:^(id obj) {
            
            for (int i = 0; i<[obj count]; i++) {
                LLPBillboardUserInfo* info = obj[i];
                UIImageView * icon;
                switch (i) {
                    case 0:
                        icon = _infoViewCell.firstIcon;
                        break;
                    case 1:
                        icon = _infoViewCell.secondIcon;
                        break;
                    case 2:
                        icon = _infoViewCell.thirdIcon;
                        break;
                    default:
                        break;
                }
                [icon downloadImage:[LLPUtils getCompletePictureLinks:info.user.portrait widht:64 Height:64] placeholder:@"default_room"];
            }
            
        } filed:^(id obj) {
            
        }];
        
        //关注&粉丝
        NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",(int)self.infoData.idField],@"id",nil];
        [LLPOtherUserInfoHandler executeGetOtherUserFollowInfoTaskWithParams:dic2 Success:^(id obj) {
            LLPFollowInfo * fans = (LLPFollowInfo*)obj;
            _infoViewCell.fansLb.text = [NSString stringWithFormat:@"粉丝 %@",[LLPUtils getDigitalEllipsisDisplay:fans.numFollowers]];
            _infoViewCell.focusLb.text = [NSString stringWithFormat:@"关注 %@",[LLPUtils getDigitalEllipsisDisplay:fans.numFollowings]];
        } filed:^(id obj) {
            
        }];
        
        if (![self.infoData.descriptionField isEqualToString:@" "]) {
            [_infoViewCell.descriptionLb setTitle:self.infoData.descriptionField forState:UIControlStateNormal];
        }
        
        
        
    }
    return _infoViewCell;
}


- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 60;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer * _Nonnull timer) {
        self.tableView.tableHeaderView = self.infoView;
        
        //滑动列表，顶部头像的拉伸[backgroundView]
        self.tableView.backgroundView = [[UIView alloc] init];
        self.imageVC = [[UIImageView alloc] init];
        self.imageVC.frame = CGRectMake(0, 0, SCREEN_WIDTH,BGHEIGHT);
        NSLog(@"self.infoData.portrait %@",self.infoData.portrait);
        [self.imageVC downloadImage:self.infoData.portrait placeholder:@"default_room"];
        self.imageVC.contentMode = UIViewContentModeScaleAspectFill;
        self.imageVC.clipsToBounds = YES;
        [self.tableView.backgroundView addSubview:self.imageVC];
        self.collectionHeight = 0;
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"is_all",
                              [NSString stringWithFormat:@"%d",(int)self.infoData.idField],@"owner_uid",
                              USER_ID,@"uid",
                              SID,@"sid",nil];
        
        [LLPOtherUserInfoHandler executeGetOtherUseFeedsInfoTaskWithParams:dic Success:^(id obj) {
            self.dataList = [obj mutableCopy];
            self.collectionHeight = self.dataList.count/2*(SCREEN_WIDTH/2-1)/0.623;
            [self.tableView reloadData];
            [self.collectionView reloadData];
            
            UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            self.tableView.tableFooterView = bottomView;
            
            UILabel * over = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            over.text = @"已经全部加载完毕";
            over.textColor = RGB(79, 79, 79);
            over.textAlignment = NSTextAlignmentCenter;
            over.font = [UIFont systemFontOfSize:15];
            [bottomView addSubview:over];
            
            
        } filed:^(id obj) {
            
        }];
        
    } repeats:NO];
    
    //设置分割线颜色
//    [self.tableView setSeparatorColor:RGBA(207, 207, 207,0.6)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bottomView];
    [self.tableView.backgroundView bringSubviewToFront:bottomView];
    
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).with.offset(0);
//        make.right.equalTo(self.view).with.offset(0);
//    }];
//    
    [self infoViewCell];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.collectionHeight == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            return self.infoViewCell;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    
            //此处必须要有创见一个UICollectionViewFlowLayout的对象
            UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
            //同一行相邻两个cell的最小间距
            layout.minimumInteritemSpacing = 0;
            //最小两行之间的间距
            layout.minimumLineSpacing = 2;
            layout.itemSize = CGSizeMake((SCREEN_WIDTH-2)/2, (SCREEN_WIDTH/2-2)/0.623);
            self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.collectionHeight) collectionViewLayout:layout];
            self.collectionView.backgroundColor=[UIColor whiteColor];
            self.collectionView.delegate=self;
            self.collectionView.dataSource=self;
            self.collectionView.scrollEnabled = NO;
            UINib *cellNib=[UINib nibWithNibName:@"LLPShreListViewCell" bundle:nil];
            [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:identifier2];
            [cell.contentView addSubview:self.collectionView];

        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 140;
    }else if (indexPath.section == 1){
        return self.collectionHeight;
    }
    return 0.1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffSet = scrollView.contentOffset.y;
    CGRect oldFream = self.imageVC.frame;
    if(contentOffSet <= BGHEIGHT){
        oldFream.size.height = BGHEIGHT-contentOffSet;
        self.imageVC.frame = oldFream;
    }
}

-(void)userInfoData:(LLPUserInfo *)info{
    self.infoData = info;
}


- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

////一共有多少个组
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return ceil(self.dataList.count/2);
//}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LLPShreListViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier2 forIndexPath:indexPath];
    [cell FeedsInfo:self.dataList[indexPath.section*2+indexPath.row]];
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 2, 0);
}

//定义每一个cell的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(SCREEN_WIDTH/2-1, (SCREEN_WIDTH/2-1)/0.623);
//}

//cell的点击事
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath----%d",(int)indexPath.row);
}

@end
