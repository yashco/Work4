//
//  LoadingViewController.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "LoadingViewController.h"
#import "StartViewController.h"
#include "AppDelegate.h"

#import "UseInfo.h"
#include "SocialNetwork.h"

@interface LoadingViewController ()<Social>{
        AppDelegate* m_pAppDelegate;
        SocialNetwork* m_pSocialNetwork;
}

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pAppDelegate = objAppDelegate;
    m_pSocialNetwork = [[SocialNetwork alloc] initWithDeleget:self];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backImg.image = [UIImage imageNamed:@"2 Intro.png"];
    
    [self.view addSubview:backImg];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)tapView:(UIGestureRecognizer *)gesture{
    UseInfo* m_pUseInfo = [UseInfo useInfo];
    if(m_pUseInfo){
        
        [m_pAppDelegate regLoginReq:LogInWith_none userType:0 usrinfo:m_pUseInfo regOrLogin:FALSE withCompletionHandler:^(NSDictionary* data) {
            
            if(data){
                NSString* errorno = [NSString stringWithFormat:@"%@",data[KEY_ERROR]];
                NSString* msg = [NSString stringWithFormat:@"%@",data[KEY_MESSAGE]];
                if([errorno isEqualToString:@"0"])
                {
                    [m_pUseInfo updateUserInfoWith:data userinfo:m_pUseInfo];
                    [m_pAppDelegate initMainRun];
                }
                else
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:11];
            }else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to login please try after some time" tag:2];
            }
        }];
        
    }else
        [m_pSocialNetwork checkForSocialLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----CallBackFromSocialNetwork-----
-(void)alreadyLoginwith:(LogInWith)name islogin:(BOOL)isLogin{
    
    if(name == LogInWith_none && isLogin == FALSE)
    {
        StartViewController *startView = [[StartViewController alloc] init];
        [self.navigationController pushViewController:startView animated:YES];
        
    }else{
        [m_pSocialNetwork fetchUserInfoFrom:name];
    }
    
}
-(void)logInWith:(LogInWith)name islogin:(BOOL) islogin{
    
}
-(void)logOutFromAll{
    
}
-(void)fetchUserInfoFrom:(LogInWith)name isfetched:(BOOL)fetched userinfo:(UseInfo*) usrinfo{
    if(name != LogInWith_none && fetched && usrinfo){
        
        [m_pAppDelegate regLoginReq:name userType:0 usrinfo:usrinfo regOrLogin:FALSE withCompletionHandler:^(NSDictionary* data) {
            
            if(data){
                NSString* errorno = [NSString stringWithFormat:@"%@",data[KEY_ERROR]];
                NSString* msg = [NSString stringWithFormat:@"%@",data[KEY_MESSAGE]];
                if([errorno isEqualToString:@"0"])
                {
                    [usrinfo updateUserInfoWith:data userinfo:usrinfo];
                    [m_pAppDelegate initMainRun];
                }
                else {
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:1];
                }
            }else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to login please try after some time" tag:2];
            }
        }];
    }
}
#pragma mark ---UIAlertView---
-(void)ShowAlartMSG:(NSString*)title msg:(NSString*)msg tag:(int) tag{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    switch (alertView.tag) {
        case 1:{
            StartViewController *startView = [[StartViewController alloc] init];
            [self.navigationController pushViewController:startView animated:YES];
        }
            break;
        default:
            break;
    }
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
