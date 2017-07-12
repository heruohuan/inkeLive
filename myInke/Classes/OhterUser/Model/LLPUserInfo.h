//
//	LLPUser.h
//
//	Create by heruohuan on 2/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "LLPLiverank.h"

@interface LLPUserInfo : NSObject

@property (nonatomic, strong) NSString * birth;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * emotion;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger gmutex;
@property (nonatomic, strong) NSString * hometown;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger inkeVerify;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) LLPLiverank * liverank;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * nick;
@property (nonatomic, strong) NSString * portrait;
@property (nonatomic, strong) NSString * profession;
@property (nonatomic, assign) NSInteger rankVeri;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString * thirdPlatform;
@property (nonatomic, strong) NSString * veriInfo;
@property (nonatomic, assign) NSInteger verified;
@property (nonatomic, strong) NSString * verifiedReason;
@end
