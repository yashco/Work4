//
//  AppDelegate.h
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "RESideMenu.h"

#import <CoreLocation/CoreLocation.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#include "AppConstant.h"
@class UseInfo;


@interface AppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate, MBProgressHUDDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CLLocation *mUserCurrentLocation;

@property NSString * socialmediaChoise;

- (void)showProgressHUD:(NSString*)title;
- (void)hideProgressHUD;

+(AppDelegate*)sharedAppDelegate;

-(void)initMainRun;
-(void)initLoading;
-(void)initStart;

-(void) updateCurrentLocation;
-(CLLocation *) getCurrentLocation;

-(void) showAPIPage;
-(void) showAPIResponsePage:(NSString *)method status:(int)statusCode request:(NSString *)requestUrl response:(NSString *)response;
- (void)showDeepLinkPage;
- (void)resetDefaults;
-(void)regLoginReq:(LogInWith)name userType:(int) userType usrinfo:(UseInfo*)userinfo regOrLogin:(BOOL) isreg withCompletionHandler:(void (^)(NSDictionary * dic))completionHandler;
@end

