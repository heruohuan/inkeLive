//
//  LLPLocationManager.m
//  myInke
//
//  Created by He_bi on 2017/5/12.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPLocationManager.h"

@interface LLPLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager * locationManager;
@property (nonatomic,copy) LocationBlock block;


@end

@implementation LLPLocationManager

+(instancetype) sharedManager{
    
    static LLPLocationManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[LLPLocationManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.distanceFilter = 100;
        _locationManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启定位服务");
        }else{
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                //前台使用
                [_locationManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    CLLocationCoordinate2D coor =  newLocation.coordinate;
        
    NSString * lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString * lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    self.block(lat, lon);
    [LLPLocationManager sharedManager].lat = lat;
    [LLPLocationManager sharedManager].lon = lon;
    
    [self.locationManager stopUpdatingLocation];
}

-(void) getGPS:(LocationBlock)block{
    self.block = block;
    [self.locationManager startUpdatingLocation];
}

@end
