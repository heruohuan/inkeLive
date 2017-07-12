//
//  APIConfig.h
//  myInke
//
//  Created by He_bi on 2017/5/7.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

//服务器地址
#define SERVER_HOST @"http://service.ingkee.com/"

//自身用户ID
#define USER_ID @"2023980"
#define SID @"20EVVH8Ce9k9WuMBdZVKMBJoS6rcpttARl2HILi0U3Drhlz4wi3i3"


//热门直播（首页）top 5
#define API_HotLive @"api/live/gettop?imsi=&uid"

//热门 前200名
#define API_HotLiveAll @"api/live/simpleall?imsi=&uid"

//好声音
#define API_GoodMusic @"api/live/theme_guide?keyword=REMENABC"

//附近的人
#define API_NearLive @"api/live/near_recommend"//?uid=85149891&latitude=31.090562&longitude=121.413353

//获取指定用户信息
#define API_UserInfo @"api/user/info?"

//广告地址
#define API_ADvertise @"advertise/get"

//直播地址
#define Live_He_bi @"rtmp://203.207.99.19:1935/live/hebi"

//获取用户主页信息
#define API_UserHomePageInfo @"api/feed/feeds?"//owner_uid=%@=&uid=%@&sid=%@

//获取用户印象
#define API_UserImpression @"user/label/TopLabels?"//host_uid=%@

//获取用户是否处于直播状态及信息
#define API_UserLiveInfo @"/api/live/now_publish?"//id=%@&lc=0000000000000055&cc=TG0001&cv=IK4.0.40_Iphone&proto=7&idfa=00000000-0000-0000-0000-000000000000&idfv=4EA1F213-006A-47EA-886F-972195A69B1E&devi=2cf69a2ddfb3f3e56ca75c61687df24089dfc4ed&osversion=ios_10.200000&ua=iPhone9_1&uid=%@&sid=%@&s_sg=29ecaaee06436ad1fc442b5e5fd049e2&s_sc=100&s_st=1499121335

//获取用户奉献榜中的前三名
#define API_GiveTopThree @"api/statistic/contribution"//?count=3&id=%@&uid=%@&sid=%@

//获取用户微博信息
#define API_WeiboInfo @"api/user/weibo_isbind?"//id=%@&uid=%@&sid=%@

//获取用户送出的钻石以及得到映票数量
#define API_DiamondsYingPiao @"api/statistic/inout?"//id=%@&uid=%@

//获取用户的粉丝和关注数量
#define API_AttentionNumberFans @"/api/user/relation/numrelations?"//id=%@

//获取用户的所有小视频GIF等分享
#define API_UserShreInfo @"api/feed/feeds?"//is_all=1&owner_uid=%@&uid=%@&sid=%@

#define API_ImageScale @"http://image.scale.inke.com/imageproxy2/dimgm/scaleImage?"









 @end
