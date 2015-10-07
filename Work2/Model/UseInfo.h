//
//  useInfo.h
//  Works2
//
//  Created by OD BASE 1 on 23/7/15.
//  Copyright (c) 2015 OD BASE 1. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface UseInfo : NSObject

@property(nonatomic,strong)NSString *first_name;
@property(nonatomic,strong)NSString *last_name;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *socialname;
@property(nonatomic,strong)NSString *socialid;
@property(nonatomic,strong)NSString *reg_date;
@property(nonatomic,copy) NSString  *imageUrl;

@property(nonatomic,strong)NSString *registerType;
@property(nonatomic,strong)NSString *loginType;
@property(nonatomic,strong)NSString *userType;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,copy) NSString  *dob;

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *facebookid;
@property(nonatomic,strong)NSString *linkedinid;
@property(nonatomic,strong)NSString *twitterid;
@property(nonatomic,strong)NSString *status;


+(id)parseUserInfoData:(NSDictionary *)dataDic;


+ (void)saveUserInfo:(UseInfo *)useInfo;

+ (UseInfo *)useInfo;

//-(NSString *)registerUser;
-(void)updateUserInfoWith:(NSDictionary*)dic userinfo:(UseInfo*)m_pUseInfo;
    
    
    
    
    
    

    
    


@end
