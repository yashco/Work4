//
//  SocialNetwork.m
//  Work2
//
//  Created by yashco sys on 03/10/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "SocialNetwork.h"
#import "AppDelegate.h"

#import "MBProgressHUD+MJ.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import <linkedin-sdk/LISDKSessionManager.h>
#import "UIImageView+WebCache.h"
#import "UseInfo.h"
#import "JobMainViewController.h"

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#include "AppConstant.h"
#include "UseInfo.h"
#include "AppDelegate.h"

@interface SocialNetwork (){
    
    AppDelegate* m_pAppDelegate;
}
//-(void)logInWithFaceBook:(void (^)(BOOL))completed;
//-(void)checkFaceBookLogin:(void (^)(BOOL))completed;
//-(void)logOutFacebook:(void (^)(BOOL))completed;
@end



@implementation SocialNetwork
-(id)initWithDeleget:(id)dlget{
    self = [super init];
    if(self)
    {
        self.delegate = dlget;
        m_pAppDelegate = objAppDelegate;
    }
    return self;
}
-(void)logOutFromAll{
    [self checkFaceBookLogin:^(BOOL islogin){
        if(islogin)
        {
            [self logOutFromFacebook];
            [[self delegate] logOutFromAll];
        }else
        {
            [[self delegate] logOutFromAll];
        }
    }];
    [m_pAppDelegate resetDefaults];
}
-(void)checkForSocialLogin{
    
    [self checkFaceBookLogin:^(BOOL islogin){
        if(islogin)
        {
            [[self delegate] alreadyLoginwith:LogInWith_FB islogin:TRUE];
        }else
        {
            [[self delegate] alreadyLoginwith:LogInWith_none islogin:FALSE];
        }
    }];
    
}
-(void)startLoginWith:(LogInWith)name{
    
    switch (name) {
        case LogInWith_none:
        {
        }
        break;
        case LogInWith_FB:
        {
            [self checkFaceBookLogin:^(BOOL islogin){
                
                if(islogin)
                {
                    [[self delegate] alreadyLoginwith:name islogin:islogin];
                    
                }else
                {
                    [self logInWithFaceBook:^(BOOL islogin_) {
                        
                        [[self delegate] logInWith:name islogin:islogin_];
                        
                    }];
                }
            }];
        }
        break;
        case LogInWith_linkedin:
        {
            
        }
        break;
        case LogInWith_twitter:
        {
            
        }
        break;
            
        default:
            break;
    }
}
-(void)fetchUserInfoFrom:(LogInWith)name{
    
    switch (name) {
        case LogInWith_none:
        {
        }
            break;
        case LogInWith_FB:
        {
            [self checkFaceBookLogin:^(BOOL islogin){
                
                if(islogin)
                {
                    [self fetchUserInfoFromFacebook:^(BOOL fetched,UseInfo* usrinfo) {
                        [[self delegate] fetchUserInfoFrom:name isfetched:fetched userinfo:usrinfo];
                    }];
                    
                }else
                {
                    [self logInWithFaceBook:^(BOOL islogin_) {
                        
                        if(islogin_)
                        {
                            [self fetchUserInfoFromFacebook:^(BOOL fetched,UseInfo* usrinfo) {
                                [[self delegate] fetchUserInfoFrom:name isfetched:fetched userinfo:usrinfo];
                            }];
                        }else{
                            
                            [[self delegate] logInWith:LogInWith_FB islogin:islogin_];
                        }
                        
                    }];
                }
            }];
        }
            break;
        case LogInWith_linkedin:
        {
            
        }
            break;
        case LogInWith_twitter:
        {
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark FaceBook
-(void)checkFaceBookLogin:(void (^)(BOOL))completed
{
    if([FBSDKAccessToken currentAccessToken])
    {
        [FBSDKAccessToken refreshCurrentAccessToken:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if(NULL == error)
            {
                completed(true);
            }
            else
                completed(false);
        }];
    }
    else
        completed(false);
}
-(void)logInWithFaceBook:(void (^)(BOOL))completed
{
    //[[UIApplication  sharedApplication]canOpenURL:[NSURL URLWithString:@"fbauth://authorize"]];
    AppDelegate *delegate = objAppDelegate;
    delegate.socialmediaChoise = @"facebook";
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if(NULL == error && result && !result.isCancelled)
        {
            completed(true);
        }
        else
            completed(false);
    }];
}
-(void)fetchUserInfoFromFacebook:(void (^)(BOOL,UseInfo*))completed{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,email,first_name,last_name,location,picture.width(100).height(100)" forKey:@"fields"];

        [[[FBSDKGraphRequest alloc] initWithGraphPath:[FBSDKAccessToken currentAccessToken].userID parameters:parameters]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {

            if (!error && result)
            {
                NSMutableDictionary* fbuserinfo = [[NSMutableDictionary alloc] init];
                [fbuserinfo setObject:SOCIAL_FB_NAME forKey:KEY_SOCIALNAME];
                [fbuserinfo setObject:[result valueForKey:@"id"] forKey:KEY_SOCIALID];
                [fbuserinfo setObject:[result valueForKey:@"first_name"] forKey:KEY_FIRST_NAME];
                [fbuserinfo setObject:[result valueForKey:@"last_name"] forKey:KEY_LAST_NAME];
                [fbuserinfo setObject:[result valueForKey:KEY_EMAIL_ADD] forKey:KEY_EMAIL_ADD];
                [fbuserinfo setObject:[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:KEY_PRO_IMG_URL];
                 UseInfo *userInfo = [UseInfo parseUserInfoData:fbuserinfo];
                completed(TRUE,userInfo);
            }
            else
                completed(FALSE,NULL);
        }];
    }
}
-(void)logOutFromFacebook{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
}
@end
