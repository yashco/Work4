//
//  LogInViewController.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"

#import "MBProgressHUD+MJ.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import <linkedin-sdk/LISDKSessionManager.h>
#import "UIImageView+WebCache.h"
#import "JobMainViewController.h"
#import "LogInViewController.h"

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

#import "UseInfo.h"
#include "SocialNetwork.h"

@interface LogInViewController ()<UITextFieldDelegate,MBProgressHUDDelegate,Social>
{
    UITextField *emailTxt;
    UITextField *passwordTxt;
    UIView *whiteBack;
    CGPoint whiteBackPoint;
    SocialNetwork* m_pSocialNetwork;
    AppDelegate* m_pAppDelegate;
}
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    m_pAppDelegate = objAppDelegate;
    m_pSocialNetwork = [[SocialNetwork alloc] initWithDeleget:self];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backImg.image = [UIImage imageNamed:@"2 Intro.png"];
    [self.view addSubview:backImg];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,20, 30, 30)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTintColor:[UIColor lightGrayColor]];
    backBtn.alpha = 1.0;
    backBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:backBtn];
    
    whiteBackPoint = CGPointMake(15,50);
    whiteBack = [[UIView alloc] initWithFrame:CGRectMake(whiteBackPoint.x,whiteBackPoint.y, self.view.frame.size.width - 30, self.view.frame.size.height - 70)];
    whiteBack.backgroundColor = [UIColor whiteColor];
    whiteBack.layer.cornerRadius = 15;
    whiteBack.layer.borderColor = [UIColor lightGrayColor].CGColor;
    whiteBack.layer.borderWidth = 2;
    whiteBack.layer.masksToBounds = YES;
    [self.view addSubview:whiteBack];
    
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(whiteBack.frame.size.width/2 - 30, 5, 60, 50)];
    logoImg.image = [UIImage imageNamed:@"W Copy.png"];
    [whiteBack addSubview:logoImg];
    
    UIImageView *worksImg = [[UIImageView alloc] initWithFrame:CGRectMake(whiteBack.frame.size.width/2 - 30, 60, 60, 40)];
    worksImg.image = [UIImage imageNamed:@"WORKS.png"];
    [whiteBack addSubview:worksImg];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, whiteBack.frame.size.width, 25)];
    titleLbl.text = @"Log in using";
    titleLbl.font = [UIFont systemFontOfSize:20.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [whiteBack addSubview:titleLbl];
    
    UIButton *facebookBtn = [[UIButton alloc] initWithFrame:CGRectMake(whiteBack.frame.size.width/2 - 30, titleLbl.frame.origin.y + titleLbl.frame.size.height + 5, 60, 60)];
    [facebookBtn setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(facebookBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [facebookBtn setTintColor:[UIColor lightGrayColor]];
    facebookBtn.alpha = 1.0;
    facebookBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [whiteBack addSubview:facebookBtn];
    
    UIButton *linkedinBtn = [[UIButton alloc] initWithFrame:CGRectMake(facebookBtn.frame.origin.x - 80, titleLbl.frame.origin.y + titleLbl.frame.size.height + 5, 60, 60)];
    [linkedinBtn setBackgroundImage:[UIImage imageNamed:@"Linkedin.png"] forState:UIControlStateNormal];
    [linkedinBtn addTarget:self action:@selector(linkedinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [linkedinBtn setTintColor:[UIColor lightGrayColor]];
    linkedinBtn.alpha = 1.0;
    linkedinBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [whiteBack addSubview:linkedinBtn];
    
    UIButton *twitterBtn = [[UIButton alloc] initWithFrame:CGRectMake(facebookBtn.frame.origin.x + 60, titleLbl.frame.origin.y + titleLbl.frame.size.height + 5, 60, 60)];
    [twitterBtn setBackgroundImage:[UIImage imageNamed:@"Twitter.png"] forState:UIControlStateNormal];
    [twitterBtn addTarget:self action:@selector(twitterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [twitterBtn setTintColor:[UIColor lightGrayColor]];
    twitterBtn.alpha = 1.0;
    twitterBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [whiteBack addSubview:twitterBtn];
    
    UILabel *titleLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, twitterBtn.frame.size.height + twitterBtn.frame.origin.y + 10, whiteBack.frame.size.width, 20)];
    titleLbl2.text = @"or use your Email address";
    titleLbl2.font = [UIFont systemFontOfSize:15.0];
    titleLbl2.textAlignment = NSTextAlignmentCenter;
    titleLbl2.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [whiteBack addSubview:titleLbl2];
    
    UIImageView *emailTxtBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, twitterBtn.frame.size.height + twitterBtn.frame.origin.y + 40, whiteBack.frame.size.width - 20, 40)];
    emailTxtBack.image = [UIImage imageNamed:@"txtBack.png"];
    [whiteBack addSubview:emailTxtBack];
    
    emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(emailTxtBack.frame.origin.x + 10, emailTxtBack.frame.origin.y + 3, emailTxtBack.frame.size.width - 20, 34)];
    emailTxt.delegate = self;
    emailTxt.placeholder = @"Email address";
    emailTxt.backgroundColor = [UIColor clearColor];
    emailTxt.textColor = [UIColor blackColor];
    emailTxt.font = [UIFont systemFontOfSize:16];
    [emailTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    emailTxt.returnKeyType = UIReturnKeyNext;
    emailTxt.keyboardType = UIKeyboardTypeEmailAddress;
    [whiteBack addSubview:emailTxt];
    
    UIImageView *passTxtBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, emailTxtBack.frame.size.height + emailTxtBack.frame.origin.y + 10, whiteBack.frame.size.width - 20, 40)];
    passTxtBack.image = [UIImage imageNamed:@"txtBack.png"];
    [whiteBack addSubview:passTxtBack];
    
    passwordTxt = [[UITextField alloc] initWithFrame:CGRectMake(passTxtBack.frame.origin.x + 10, passTxtBack.frame.origin.y + 3, passTxtBack.frame.size.width - 20, 34)];
    passwordTxt.delegate = self;
    passwordTxt.placeholder = @"Password";
    passwordTxt.backgroundColor = [UIColor clearColor];
    passwordTxt.textColor = [UIColor blackColor];
    passwordTxt.font = [UIFont systemFontOfSize:16];
    [passwordTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTxt.returnKeyType = UIReturnKeyGo;
    passwordTxt.secureTextEntry = YES;
    [whiteBack addSubview:passwordTxt];

    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(whiteBack.frame.size.width/2 - 100, passTxtBack.frame.size.height + passTxtBack.frame.origin.y + 10, 200, 40)];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"jobseekerBtn.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTintColor:[UIColor lightGrayColor]];
    loginBtn.alpha = 1.0;
    loginBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [whiteBack addSubview:loginBtn];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:gesture];
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.2 animations:^{
        whiteBack.frame = CGRectMake(whiteBackPoint.x,whiteBackPoint.y - 150, whiteBack.frame.size.width, whiteBack.frame.size.height);
    }completion:^(BOOL finished){
        
    }];
    return YES;
}
- (void)tapView:(UIGestureRecognizer *)gesture{
    
    [UIView animateWithDuration:0.2 animations:^{
        whiteBack.frame = CGRectMake(whiteBackPoint.x,whiteBackPoint.y, whiteBack.frame.size.width, whiteBack.frame.size.height);
    }completion:^(BOOL finished){
        
    }];
    
    [emailTxt resignFirstResponder];
    [passwordTxt resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (textField == emailTxt) {
        [textField resignFirstResponder];
        [passwordTxt becomeFirstResponder];
    }
    else{
        [self loginBtnClicked];
    }
    return YES;
}

- (void)loginBtnClicked{

     [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        whiteBack.frame = CGRectMake(whiteBackPoint.x,whiteBackPoint.y, whiteBack.frame.size.width, whiteBack.frame.size.height);
    }completion:^(BOOL finished){
        
    }];
    
    
    if (![self NSStringIsValidEmail:emailTxt.text]) {
        [self ShowAlartMSG:KEY_ERROR msg:@"Please input an valid email" tag:2];
        return;
    }else if (passwordTxt.text.length<=0){
        [self ShowAlartMSG:KEY_ERROR msg:@"Password should not be empty" tag:2];
    }
    else{
        
        NSMutableDictionary* user_info = [[NSMutableDictionary alloc] init];
        [user_info setObject:SOCIAL_NONE forKey:KEY_SOCIALNAME];
        [user_info setObject:emailTxt.text forKey:KEY_EMAIL_ADD];
        [user_info setObject:passwordTxt.text forKey:KEY_PASSWORD];
        
        UseInfo *userInfo = [UseInfo parseUserInfoData:user_info];
        
        [m_pAppDelegate regLoginReq:LogInWith_none userType:0 usrinfo:userInfo regOrLogin:FALSE withCompletionHandler:^(NSDictionary* data) {
            
            if(data){
                NSString* errorno = [NSString stringWithFormat:@"%@",data[KEY_ERROR]];
                NSString* msg = [NSString stringWithFormat:@"%@",data[KEY_MESSAGE]];
                if([errorno isEqualToString:@"0"])
                {
                    [userInfo updateUserInfoWith:data userinfo:userInfo];
                    [m_pAppDelegate initMainRun];
                }
                else
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:11];
            }else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to login please try after some time" tag:2];
            }
        }];
    }
}

- (void)backBtnClicked{
    [m_pSocialNetwork logOutFromAll];
}

- (void)linkedinBtnClicked{

}

- (void)updateControlsWithResponseLabel:(BOOL)updateResponseLabel {
    
    
}
- (void)facebookBtnClicked{

    [m_pSocialNetwork fetchUserInfoFrom:LogInWith_FB];
    
}

-(NSString *)getTwImageURLStr:(NSString *)TW_userImageUrlStr{
    
    self.twImageURLStr = TW_userImageUrlStr;
    
    return self.twImageURLStr;
}


- (void)twitterBtnClicked{

    
}


//check if the email is valid or already used
-(BOOL)NSStringIsValidEmail:(NSString *)checkString{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
    
}
#pragma mark-----CallBackFromSocialNetwork-----
-(void)alreadyLoginwith:(LogInWith)name islogin:(BOOL)isLogin{

}
-(void)logInWith:(LogInWith)name islogin:(BOOL) islogin{

}
-(void)logOutFromAll{
    
    [self dismissViewControllerAnimated:YES completion:nil];

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
            [self backBtnClicked];
        }
         break;
        default:
         break;
    }
}
@end
