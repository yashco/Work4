//
//  AppConstant.h
//  Work2
//
//  Created by yashco sys on 03/10/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#ifndef Work2_AppConstant_h
#define Work2_AppConstant_h

#define BASE_URL @"http://yashco.info/odbaseapi/index.php/user/"
#define objAppDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

#define JOBSEEKER 1
#define RECRUITER 2

#define SOCIAL_NONE          @"NM"
#define SOCIAL_FB_NAME       @"FB"
#define SOCIAL_LINKEDIN_NAME @"LN"
#define SOCIAL_TWITTER_NAME  @"TW"

#define USER_TYPE_SEEKAR @"seekar"
#define USER_TYPE_EMPLOYER @"employer"


#define KEY_USER          @"user"
#define KEY_ERROR         @"Error"
#define KEY_MESSAGE       @"Message"
#define KEY_METHOD        @"method"
#define KEY_REGISTERTYPE  @"registerType"
#define KEY_LOGINTYPE     @"loginType"
#define KEY_USERTYPE      @"userType"
#define KEY_LATITUDE      @"latitude"
#define KEY_lONGITUDE     @"longitude"
#define KEY_PASSWORD      @"password"
#define KEY_DOB           @"dob"
#define KEY_FIRST_NAME    @"firstName"
#define KEY_LAST_NAME     @"LastName"
#define KEY_MODE          @"mode"
#define KEY_EMAIL_ADD     @"email"
#define KEY_SOCIALNAME    @"socianame"
#define KEY_SOCIALID      @"socialid"
#define KEY_REG_DATE      @"reg_date"
#define KEY_PRO_IMG_URL   @"imageUrl"
#define KEY_USER_ID       @"id"
#define KEY_TWITTER_ID    @"twitterToken"
#define KEY_LINKEDIN_ID   @"linkedinToken"
#define KEY_FACEBOOK_ID   @"facebookToken"
#define KEY_STATUS        @"status"


typedef enum : NSUInteger {
    LogInWith_none,
    LogInWith_FB,
    LogInWith_linkedin,
    LogInWith_twitter,
} LogInWith;


#endif
