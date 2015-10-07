//
//  SignUpViewController.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"

#import "MBProgressHUD+MJ.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import <linkedin-sdk/LISDKSessionManager.h>
#import "UIImageView+WebCache.h"
#import "UseInfo.h"
#import "JobMainViewController.h"
#import "LogInViewController.h"

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#include "AppConstant.h"

#include "SocialNetwork.h"

//#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"account.plist"];

@interface SignUpViewController ()<UITextFieldDelegate,MBProgressHUDDelegate,Social>
{
    UITextField *emailTxt;
    UITextField *passwordTxt;
    UITextField *confirmPassTxt;
    UIView *whiteBack;
    CGPoint whiteBackPoint;
    int userType;
    SocialNetwork* m_pSocialNetwork;
    AppDelegate* m_pAppDelegate;
}
@property(nonatomic,strong)UseInfo *userInfo;

@end

@implementation SignUpViewController
- (id)initWithUserType:(int)_userType
{
    self = [super init];
    if(self)
    {
        userType = _userType;
        m_pAppDelegate = objAppDelegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    if(JOBSEEKER == userType)
        titleLbl.text = @"Register as a Jobseeker";
    else
        titleLbl.text = @"Register as a Recruiter";
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
    
    UIImageView *emailTxtBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, twitterBtn.frame.size.height + twitterBtn.frame.origin.y + 10, whiteBack.frame.size.width - 20, 40)];
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
    passwordTxt.returnKeyType = UIReturnKeyNext;
    passwordTxt.secureTextEntry = YES;
    [whiteBack addSubview:passwordTxt];
    
    UIImageView *confirmPassTxtBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, passTxtBack.frame.size.height + passTxtBack.frame.origin.y + 10, whiteBack.frame.size.width - 20, 40)];
    confirmPassTxtBack.image = [UIImage imageNamed:@"txtBack.png"];
    [whiteBack addSubview:confirmPassTxtBack];
    
    confirmPassTxt = [[UITextField alloc] initWithFrame:CGRectMake(confirmPassTxtBack.frame.origin.x + 10, confirmPassTxtBack.frame.origin.y + 3, confirmPassTxtBack.frame.size.width - 20, 34)];
    confirmPassTxt.delegate = self;
    confirmPassTxt.placeholder = @"Confirm Password";
    confirmPassTxt.backgroundColor = [UIColor clearColor];
    confirmPassTxt.textColor = [UIColor blackColor];
    confirmPassTxt.font = [UIFont systemFontOfSize:16];
    [confirmPassTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    confirmPassTxt.returnKeyType = UIReturnKeyGo;
    confirmPassTxt.secureTextEntry = YES;
    [whiteBack addSubview:confirmPassTxt];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(whiteBack.frame.size.width/2 - 100, confirmPassTxtBack.frame.size.height + confirmPassTxtBack.frame.origin.y + 10, 200, 40)];
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"jobseekerBtn.png"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTintColor:[UIColor lightGrayColor]];
    registerBtn.alpha = 1.0;
    registerBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [whiteBack addSubview:registerBtn];

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
    [confirmPassTxt resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == emailTxt) {
        [textField resignFirstResponder];
        [passwordTxt becomeFirstResponder];
    }
    else if (textField == passwordTxt){
        [textField resignFirstResponder];
        [confirmPassTxt becomeFirstResponder];
    }
    else{
        [self registerBtnClicked];
    }
    return YES;
}

- (void)registerBtnClicked{
    

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
    else if (![passwordTxt.text isEqualToString:confirmPassTxt.text]){
         [self ShowAlartMSG:KEY_ERROR msg:@"confirm password do not the same" tag:2];
        return;
    }else{
    
        NSMutableDictionary* user_info = [[NSMutableDictionary alloc] init];
        [user_info setObject:SOCIAL_NONE forKey:KEY_SOCIALNAME];
        [user_info setObject:emailTxt.text forKey:KEY_EMAIL_ADD];
        [user_info setObject:passwordTxt.text forKey:KEY_PASSWORD];

        UseInfo *userInfo = [UseInfo parseUserInfoData:user_info];
        
        [m_pAppDelegate regLoginReq:LogInWith_none userType:userType usrinfo:userInfo regOrLogin:TRUE withCompletionHandler:^(NSDictionary* data) {
            
            if(data){
                NSString* errorno = [NSString stringWithFormat:@"%@",data[KEY_ERROR]];
                NSString* msg = [NSString stringWithFormat:@"%@",data[KEY_MESSAGE]];
                if([errorno isEqualToString:@"0"])
                {
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:0];
                }
                else if([errorno isEqualToString:@"1"]){
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:1];
                }
                else{
                    [self ShowAlartMSG:KEY_ERROR msg:@"Unable to registered please try after some time" tag:2];
                }
                
            }else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to registered please try after some time" tag:2];
            }
        }];
    }
}

- (void)backBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)linkedinBtnClicked{
//    //[[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"linkedin://authorize"]];
//    [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION, nil]
//                                     state:@"some state"
//                    showGoToAppStoreDialog:YES
//      successBlock:^(NSString *returnState) {
//          LISDKAPIResponse *response;
//          
//          NSLog(@"%s","success called!");
//          LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
//          NSLog(@"value=%@ isvalid=%@",[session value],[session isValid] ? @"YES" : @"NO");
//          NSMutableString *text = [[NSMutableString alloc] initWithString:[session.accessToken description]];
//          [text appendString:[NSString stringWithFormat:@",state=\"%@\"",returnState]];
//          NSLog(@"Response label text %@",text);
//          NSLog(@"GOED");
//          
//          [[LISDKAPIHelper sharedInstance] apiRequest:@"https://www.linkedin.com/v1/people/~:(email-address,first-name,last-name,picture-url)"
//            method:@"GET"
//            body:[@"" dataUsingEncoding:NSUTF8StringEncoding]
//            success:^(LISDKAPIResponse *response) {
//            NSLog(@"success called %@", response.data);
//
//            dispatch_sync(dispatch_get_main_queue(), ^{
//
//            NSData *data = [response.data dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
//                                               options:kNilOptions
//                                                 error:nil];
//                
//
//            // This items needs to go in the database and regist as a user.
//            NSString *lastName = [jsonResponse objectForKey:@"lastName"];
//            NSString *firstName = [jsonResponse objectForKey:@"firstName"];
//            NSString *email = [jsonResponse objectForKey:@"emailAddress"];
//                NSString *imageStr = [jsonResponse objectForKey:@"pictureUrl"];
//                NSURL *imageUrl = [NSURL URLWithString:imageStr];
//                
//                //send to the databse to register
//                NSURL *urlRegist = [NSURL URLWithString:@"http://yashco.info/odbaseapi/index.php/user/"];
//                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRegist];
//                request.HTTPMethod = @"POST";
//                NSString *param = [NSString stringWithFormat:@"method=registration&email=%@&password=12345&registerType=LN&userType=seekar&latitude=33.333333&longitude=22.222222&firstName=%@&lastName=%@&dob=%@&profileImage=&facebookToken=%@&twitterToken=%@&linkedinToken=%@",email,firstName,lastName,nil,nil,nil,nil];
//                request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//                NSURLSession *session = [NSURLSession   sharedSession];
//                NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse * response, NSError *  error) {
//                    
//                    if (!error) {
//                        NSError *jsonError = nil;
//                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//                        
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if (!jsonError) {
//                                
//                                [MBProgressHUD showSuccess:@"login success" toView:self.view];
//                                
//                                [[AppDelegate sharedAppDelegate] initMainRun];
//                                
//                            }else{
//                                
//                                [MBProgressHUD showError:@"login failure, try again" toView:self.view];
//                                
//                                [self dismissViewControllerAnimated:YES completion:nil];
//                                
//                            }
//                        });
//                        
//                        
//                        
//                        [MBProgressHUD hideHUDForView:self.view];
//                        [MBProgressHUD hideHUD];
//                        
//                        UseInfo *userInfo = [UseInfo parseUserInfoData:dic];
//                        
//                        userInfo.socialname = SOCIAL_LINKEDIN_NAME;
//                        userInfo.first_name = firstName;
//                        userInfo.last_name = lastName;
//                        userInfo.email = email;
//                        userInfo.imageUrl = imageStr;
//                        self.userInfo = userInfo;
//                        
//                        [NSKeyedArchiver archiveRootObject:self.userInfo toFile:AccountPath];
//                        
//                    }else{
//                        
//                        [MBProgressHUD showError:@"Data missing"];
//                        
//                    }
//                    
//                }];
//                
//                [task resume];
//                
//                
//                [MBProgressHUD showSuccess:@"register succcess" toView:self.view];
//                [[AppDelegate sharedAppDelegate] initMainRun];
//
//                
//            });
//            }
//            error:^(LISDKAPIError *apiError) {
//            NSLog(@"error called %@", apiError.description);
//
//            dispatch_sync(dispatch_get_main_queue(), ^{
//            LISDKAPIResponse *response = [apiError errorResponse];
//            NSString *errorText;
//            if (response) {
//            errorText = response.data;
//            } else {
//            errorText = apiError.description;
//            }
//            });
//            }];
//      }
//        errorBlock:^(NSError *error) {
//            NSLog(@"%s %@","error called! ", [error description]);
//            
//            [self updateControlsWithResponseLabel:YES];
//        }];
//  
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
//    
//   // [MBProgressHUD showMessage:@"loading"];
//    
//    [[Twitter sharedInstance] startWithConsumerKey:@"d2Hu8IhyKLwvkIIw5LqqEOCzP" consumerSecret:@"I0feSWwSrloFHUath0Kor1yGdsv8TBEYerzz7II6RiKEwFMZa7"];
//    
//    [Fabric with:@[TwitterKit]];
//    
//    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
//        if (session) {
//           
//              __block NSString *twImageURLStr = nil;
//  
//                [[[Twitter sharedInstance] APIClient] loadUserWithID:session.userID completion:^(TWTRUser *user, NSError *error) {
//                    
//                    if (error) {
//                        
//                        [MBProgressHUD showError:@"twitter data missing"];
//                        
//                        return ;
//                    }
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        UIWindow *window = [[[UIApplication sharedApplication] windows]lastObject];
//                        [MBProgressHUD hideAllHUDsForView:window animated:YES ];
//                       
// 
//                    });
//                   
//                    twImageURLStr = [self getTwImageURLStr:user.profileImageLargeURL];
//                     self.twImageURLStr = twImageURLStr;
//                    NSLog(@"Twitter signed in as -> name = %@ id = %@ ", [session userName],[session userID]);
//                    // data needs to go to database:
//                    NSString *firstname = [session userName];
//                    NSString *lastname = @"null";
//                    NSString *email = [firstname stringByAppendingString:@"@twitter.com"];
//                    
//                    //send the userInfo post request to the odbase database
//                    NSURL *url = [NSURL URLWithString:@"http://yashco.info/odbaseapi/index.php/user/"];
//                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//                    //set the http method to post
//                    request.HTTPMethod = @"POST";
//                    //set the parameter
//                    NSString *param = [NSString stringWithFormat:@"method=registration&email=%@&password=12345&registerType=TW&userType=seekar&latitude=33.333333&longitude=22.222222&firstName=%@&lastName=%@&dob=%@&profileImage=&facebookToken=%@&twitterToken=%@&linkedinToken=%@",email,firstname,lastname,nil,nil,nil,nil];
//                    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//                    NSURLSession *URLsession = [NSURLSession   sharedSession];
//                    //set to task
//                    NSURLSessionDataTask *task = [URLsession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                        
//                        NSLog(@"response=%@",response);
//                        if(!error){
//                            
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                NSError *jasonError = nil;
//                                NSDictionary *jasonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jasonError];
//                                NSLog(@"jasonDic=%@",jasonDic);
//                                NSLog(@"data=%@",data);
//                                NSLog(@"jasonError=%@",jasonError);
//                                
//                                if(jasonError){
//                                   
//                                    UseInfo *userInfo = [UseInfo useInfo];
//                                    userInfo.first_name = firstname;
//                                    userInfo.last_name = lastname;
//                                    userInfo.email = email;
//                                    //UseInfo.userId
//                                    
//                                    userInfo.imageUrl = self.twImageURLStr;
//                                    NSLog(@"userInfo.imageUrl=%@",userInfo.imageUrl);
//                                    [NSKeyedArchiver archiveRootObject:userInfo toFile:AccountPath];
//                                    
//                                }
//                                
//                                
//                                [MBProgressHUD showSuccess:@"twitter login success"];
//                                UIWindow *window = [[[UIApplication sharedApplication] windows]lastObject];
//                                [MBProgressHUD hideAllHUDsForView:window animated:YES ];
//                                [[AppDelegate sharedAppDelegate] initMainRun];
//                            });
//                            [MBProgressHUD hideHUD];
//                
//                        }
//                        
//                    }];
//                    
//                    [task resume];
//                    
//  
//                }];
//
//            /* Get user info */
//            [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID]
//                                                      completion:^(TWTRUser *user,
//                                                                   NSError *error)
//             {
//                 if (![error isEqual:nil]) {
//                     NSLog(@"Twitter info   -> user = %@ ",user);
//                     
//                 } else {
//                     NSLog(@"Twitter error getting profile : %@", [error localizedDescription]);
//                 }
//             }];
//            
//        } else {
//            [MBProgressHUD showError:@"time out"];
//            NSLog(@"error: %@", [error localizedDescription]);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                UIWindow *window = [[[UIApplication sharedApplication] windows]lastObject];
//                                [MBProgressHUD hideAllHUDsForView:window animated:YES ];
//            });
//            
//        }
//       
//        
//        
//    }];
//    
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
}
-(void)fetchUserInfoFrom:(LogInWith)name isfetched:(BOOL)fetched userinfo:(UseInfo*) usrinfo{

    if(name != LogInWith_none && fetched && usrinfo){

        [m_pAppDelegate regLoginReq:name userType:userType usrinfo:usrinfo regOrLogin:TRUE withCompletionHandler:^(NSDictionary* data) {
           
            if(data){
                NSString* errorno = [NSString stringWithFormat:@"%@",data[KEY_ERROR]];
                NSString* msg = [NSString stringWithFormat:@"%@",data[KEY_MESSAGE]];
                if([errorno isEqualToString:@"0"])
                {
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:0];
                }
                else if([errorno isEqualToString:@"1"]){
                    [self ShowAlartMSG:KEY_MESSAGE msg:msg tag:1];
                }
                else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to registered please try after some time" tag:2];
                }
                
            }else{
                [self ShowAlartMSG:KEY_ERROR msg:@"Unable to registered please try after some time" tag:2];
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
        case 0:
        case 1:{
            LogInViewController *clientSignupView = [[LogInViewController alloc] init];
            clientSignupView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:clientSignupView animated:YES completion:nil];
        }
          break;
//        case 1:{
//            LogInViewController *clientSignupView = [[LogInViewController alloc] init];
//            clientSignupView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            [self presentViewController:clientSignupView animated:YES completion:nil];
//        }
//            break;
        default:
            
            break;
    }
//    if (buttonIndex == 0) {
//        // do something here...
//    }
}
@end
