//
//  AppDelegate.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "AppDelegate.h"

#import "LoadingViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "JobRightViewController.h"
#import "JobLeftViewController.h"
#import "JobMainViewController.h"
#include "StartViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

#import "Define.h"
#include "UseInfo.h"
#include "AppConstant.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *mainNavigationController;

@property (nonatomic, strong) MBProgressHUD* HUD;

@end

@implementation AppDelegate
@synthesize mUserCurrentLocation;

static AppDelegate* sharedDelegate = nil;

+(AppDelegate*)sharedAppDelegate{
    if (sharedDelegate == nil)
        sharedDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    return sharedDelegate;
}

#pragma mark - Showing / Hiding the loading view

- (void)showProgressHUD:(NSString*)title{
    if (self.HUD != nil){
        [self hideProgressHUD];
    }
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:self.HUD];
    
    self.HUD.delegate = self;
    self.HUD.labelText = title;
    self.HUD.square = YES;
    
    [self.HUD show:YES];
}

- (void)hideProgressHUD{
    [self.HUD hide:NO];
    [self.HUD removeFromSuperview];
}
-(void)initStart{
    StartViewController *m_pStartViewController = [[StartViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:m_pStartViewController];
    navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
}
-(void)initLoading{
    LoadingViewController *loadViewController = [[LoadingViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loadViewController];
    navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
}

-(void)initMainRun{
    JobMainViewController *mainVC = [[JobMainViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navigationController.navigationBar.hidden = YES;
    JobLeftViewController *leftMenuViewController = [[JobLeftViewController alloc] init];
    JobRightViewController *rightMenuViewController = [[JobRightViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
        
    sideMenuViewController.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sleep(3);
    [self initLoading];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([LISDKCallbackHandler shouldHandleUrl:url]) {
        
        return [LISDKCallbackHandler application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    else if([[url scheme] isEqualToString:@"fb891234917596709"]){
        
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
        
    }else{
        
        [Fabric with:@[TwitterKit]];
        
    }
    
    return YES;
    
}
#pragma mark - Get User Current Location

- (void)updateCurrentLocation {
    
    //CLLocationManager Object
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        //[self.locationManager requestAlwaysAuthorization];
    }
#endif
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //CLLocation Object
    mUserCurrentLocation = [[CLLocation alloc]init];
    mUserCurrentLocation = [locationManager location];
    
}

-(CLLocation *) getCurrentLocation{
    return mUserCurrentLocation;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    NSLog(@" updated (%f , %f)", newLocation.coordinate.latitude, newLocation.coordinate.longitude) ;
    
    if (currentLocation != nil) {
        mUserCurrentLocation = newLocation;
    }
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
}
#pragma mark REG_LOGIN_REQ
-(void)regLoginReq:(LogInWith)name userType:(int) userType usrinfo:(UseInfo*)userinfo regOrLogin:(BOOL) isreg withCompletionHandler:(void (^)(NSDictionary * dic))completionHandler{
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    if(isreg)
    {
        [request setValue:@"registration" forHTTPHeaderField:KEY_METHOD];
        if(userType == JOBSEEKER)
            userinfo.userType = USER_TYPE_SEEKAR;
        else if(userType == RECRUITER)
            userinfo.userType = USER_TYPE_EMPLOYER;
        
        if(LogInWith_none == name)
            userinfo.registerType = SOCIAL_NONE;
        else
            userinfo.registerType = userinfo.socialname;
        
        
        [request setValue:userinfo.userType forHTTPHeaderField:KEY_USERTYPE];
        [request setValue:userinfo.registerType forHTTPHeaderField:KEY_REGISTERTYPE];
        
    }
    else
    {
        if(LogInWith_none == name)
            userinfo.loginType = SOCIAL_NONE;
        else
            userinfo.loginType = userinfo.socialname;
        
        [request setValue:@"login" forHTTPHeaderField:KEY_METHOD];
        [request setValue:userinfo.loginType forHTTPHeaderField:KEY_LOGINTYPE];
    }
    [request setValue:userinfo.email forHTTPHeaderField:KEY_EMAIL_ADD];
    [request setValue:userinfo.password forHTTPHeaderField:KEY_PASSWORD];
    [request setValue:userinfo.first_name forHTTPHeaderField:KEY_FIRST_NAME];
    [request setValue:userinfo.last_name forHTTPHeaderField:KEY_LAST_NAME];
    [request setValue:userinfo.socialid forHTTPHeaderField:KEY_SOCIALID];
    [request setValue:userinfo.password forHTTPHeaderField:KEY_PASSWORD];
    [request setValue:[NSString stringWithFormat:@"%f",[self getCurrentLocation].coordinate.latitude] forHTTPHeaderField:KEY_LATITUDE];
    [request setValue:[NSString stringWithFormat:@"%f",[self getCurrentLocation].coordinate.longitude] forHTTPHeaderField:KEY_lONGITUDE];
    //[request setValue:userinfo.imageUrl forHTTPHeaderField:KEY_PRO_IMG_URL];
    [request setValue:userinfo.dob forHTTPHeaderField:KEY_DOB];
    NSString* new_urlstr = [NSString stringWithFormat:@"%@",request.URL];
    new_urlstr = [new_urlstr stringByAppendingString:@"?"];
    new_urlstr = [new_urlstr stringByAppendingString:[self getAllHeaderInString:request]];
    ;
    [request setURL:[NSURL URLWithString:new_urlstr]];
    //      request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession   sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jasonError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jasonError];
        NSString* newStr = [NSString stringWithUTF8String:[data bytes]];
        NSLog(@"\n#############\n");
        NSLog(@"response=%@",response);
        NSLog(@"jasonDic=%@",dic);
        NSLog(@"data=%@",newStr);
        NSLog(@"jasonError=%@",jasonError);
        NSLog(@"\n#############\n");
        if(NULL == error && dic)
            completionHandler(dic);
        else
            completionHandler(NULL);
    }];
    [task resume];
}
-(NSString*)getAllHeaderInString:(NSMutableURLRequest *)request{
    if(!request)
        return NULL;
    NSString* str = [[NSString alloc] init];
    NSDictionary* allher = [request allHTTPHeaderFields];
    if(allher && allher.count>0)
    {
        for (NSString* key in allher)
        {
            NSString* value = (NSString*)[allher objectForKey:key];
            str = [str stringByAppendingString:key];
            str = [str stringByAppendingString:@"="];
            str = [str stringByAppendingString:value];
            str = [str stringByAppendingString:@"&"];
        }
        if(str && str.length>0)
            str = [str substringToIndex:(str.length-1)];
    }
    else
        return NULL;
    return str;
}
#pragma mark APPDELEGET
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)resetDefaults
{
    /*******/
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    /*******/
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    //       NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    //       NSDictionary * dict = [defs dictionaryRepresentation];
    //       for (id key in dict) {
    //            [defs removeObjectForKey:key];
    //        }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    /****/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    for(int i =0; paths && i<paths.count;i++)
    {
        path = [paths objectAtIndex:i] ;
        //  NSError *error;
        
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject]))
        {
            if([fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL])
                NSLog(@"MYDELETE ==> %@",[path stringByAppendingPathComponent:filename]);
        }
    }
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    for(int i =0; paths && i<paths.count;i++)
    {
        path = [paths objectAtIndex:i] ;
        //  NSError *error;
        
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject]))
        {
            if([fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL])
                NSLog(@"MYDELETE ==> %@",[path stringByAppendingPathComponent:filename]);
        }
    }
    /****/
}
@end
