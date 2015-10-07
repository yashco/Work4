//
//  SocialNetwork.h
//  Work2
//
//  Created by yashco sys on 03/10/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstant.h"
//#include "UseInfo.h"

@class UseInfo;
@protocol Social<NSObject>

@optional
-(void)alreadyLoginwith:(LogInWith)name islogin:(BOOL) isLogin;
-(void)logInWith:(LogInWith)name islogin:(BOOL) islogin;
-(void)fetchUserInfoFrom:(LogInWith)name isfetched:(BOOL)fetched userinfo:(UseInfo*) usrinfo;
-(void)logOutFromAll;
@end


@interface SocialNetwork : NSObject
-(id)initWithDeleget:(id)dlget;
-(void)startLoginWith:(LogInWith)name;
-(void)fetchUserInfoFrom:(LogInWith)name;
-(void)logOutFromAll;
-(void)checkForSocialLogin;
@property (retain) id delegate;
@end
