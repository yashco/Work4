//
//  useInfo.m
//  Works2
//
//  Created by OD BASE 1 on 23/7/15.
//  Copyright (c) 2015 OD BASE 1. All rights reserved.
//

#import "UseInfo.h"
#include "AppConstant.h"

@implementation UseInfo


/*
 
 @property(nonatomic,strong)NSString *userId;
 @property(nonatomic,strong)NSString *first_name;
 @property(nonatomic,strong)NSString *last_name;
 @property(nonatomic,strong)NSString *mode;
 @property(nonatomic,strong)NSString *emailAddre;
 
 @property(nonatomic,strong)NSString *socialmedia;
 @property(nonatomic,strong)NSString *reg_date;
 @property(nonatomic,copy)NSString *imageUrl;
 
 */



-(id)initWithDictionaryData:(NSDictionary *)dataDic{
    
    if (self = [super init]) {
        self.first_name = dataDic[KEY_FIRST_NAME];
        self.user_id = dataDic[KEY_USER_ID];
        self.last_name = dataDic[KEY_LAST_NAME];
        self.email = dataDic[KEY_EMAIL_ADD];
        self.socialid = dataDic[KEY_SOCIALID];
        self.socialname = dataDic[KEY_SOCIALNAME];
        self.reg_date = dataDic[KEY_REG_DATE];
        self.imageUrl = dataDic[KEY_PRO_IMG_URL];
        self.registerType = dataDic[KEY_REGISTERTYPE];
        self.loginType = dataDic[KEY_LOGINTYPE];
        self.userType = dataDic[KEY_USERTYPE];
        self.latitude = dataDic[KEY_LATITUDE];
        self.longitude = dataDic[KEY_lONGITUDE];
        self.password = dataDic[KEY_PASSWORD];
        self.dob = dataDic[KEY_DOB];
        self.facebookid = dataDic[KEY_FACEBOOK_ID];
        self.linkedinid = dataDic[KEY_LINKEDIN_ID];
        self.twitterid = dataDic[KEY_TWITTER_ID];
        self.status = dataDic[KEY_STATUS];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.first_name forKey:KEY_FIRST_NAME];
    [encoder encodeObject:self.user_id forKey:KEY_USER_ID];
    [encoder encodeObject:self.last_name forKey:KEY_LAST_NAME];
    [encoder encodeObject:self.email forKey:KEY_EMAIL_ADD];
    [encoder encodeObject:self.socialname forKey:KEY_SOCIALNAME];
    [encoder encodeObject:self.socialid forKey:KEY_SOCIALID];
    [encoder encodeObject:self.reg_date forKey:KEY_REG_DATE];
    [encoder encodeObject:self.imageUrl forKey:KEY_PRO_IMG_URL];
    [encoder encodeObject:self.registerType forKey:KEY_REGISTERTYPE];
    [encoder encodeObject:self.loginType forKey:KEY_LOGINTYPE];
    [encoder encodeObject:self.userType forKey:KEY_USERTYPE];
    [encoder encodeObject:self.latitude forKey:KEY_LATITUDE];
    [encoder encodeObject:self.longitude forKey:KEY_lONGITUDE];
    [encoder encodeObject:self.password forKey:KEY_PASSWORD];
    [encoder encodeObject:self.dob forKey:KEY_DOB];
    
    [encoder encodeObject:self.facebookid forKey:KEY_FACEBOOK_ID];
    [encoder encodeObject:self.linkedinid forKey:KEY_LINKEDIN_ID];
    [encoder encodeObject:self.twitterid forKey:KEY_TWITTER_ID];
    [encoder encodeObject:self.status forKey:KEY_STATUS];
    

    
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    if (self = [super init]) {
        self.first_name = [decoder decodeObjectForKey:KEY_FIRST_NAME];
        self.user_id = [decoder decodeObjectForKey:KEY_USER_ID];
        self.last_name = [decoder decodeObjectForKey:KEY_LAST_NAME];
        self.email = [decoder decodeObjectForKey:KEY_EMAIL_ADD];
        self.socialid = [decoder decodeObjectForKey:KEY_SOCIALID];
        self.socialname = [decoder decodeObjectForKey:KEY_SOCIALNAME];
        self.reg_date = [decoder decodeObjectForKey:KEY_REG_DATE];
         self.imageUrl = [decoder decodeObjectForKey:KEY_PRO_IMG_URL];
        self.registerType = [decoder decodeObjectForKey:KEY_REGISTERTYPE];
        self.loginType = [decoder decodeObjectForKey:KEY_LOGINTYPE];
        self.userType = [decoder decodeObjectForKey:KEY_USERTYPE];
        self.latitude = [decoder decodeObjectForKey:KEY_LATITUDE];
        self.longitude = [decoder decodeObjectForKey:KEY_lONGITUDE];
        self.password = [decoder decodeObjectForKey:KEY_PASSWORD];
        self.dob = [decoder decodeObjectForKey:KEY_DOB];
        
        self.facebookid = [decoder decodeObjectForKey:KEY_FACEBOOK_ID];
        self.linkedinid = [decoder decodeObjectForKey:KEY_LINKEDIN_ID];
        self.twitterid = [decoder decodeObjectForKey:KEY_TWITTER_ID];
        self.status = [decoder decodeObjectForKey:KEY_STATUS];
    }
    return self;
    
}
-(void)updateUserInfoWith:(NSDictionary*)dic userinfo:(UseInfo*)m_pUseInfo{
    
    if(NULL == m_pUseInfo)
        return;
    if(dic){
        
        m_pUseInfo.userType = dic[KEY_USERTYPE];
        NSDictionary* subdic = dic[KEY_USER];
        if(subdic){
            m_pUseInfo.user_id = subdic[KEY_USER_ID];
            m_pUseInfo.facebookid = subdic[KEY_FACEBOOK_ID];
            m_pUseInfo.linkedinid = subdic[KEY_LINKEDIN_ID];
            m_pUseInfo.twitterid = subdic[KEY_TWITTER_ID];
            m_pUseInfo.status = subdic[KEY_STATUS];
        }
        
    }
    [UseInfo saveUserInfo:m_pUseInfo];
}
+ (void)saveUserInfo:(UseInfo *)useInfo{
    
    [NSKeyedArchiver archiveRootObject:useInfo toFile:AccountPath];
    NSLog(@"Path=%@",AccountPath);
}


+ (UseInfo *)useInfo{
    UseInfo *useInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    NSLog(@"Path=%@",AccountPath);
    return useInfo;
}
+(id)parseUserInfoData:(NSDictionary *)dataDic{
    
    return  [[self alloc]initWithDictionaryData:dataDic];
    
}



//-----------------------------------------
//-(NSString *)registerUserWithEmail:(NSString *)email AndPassword:(NSString *)pwd AddFirstName:(NSString *)firstName ByLastName:(NSString *)lastName AndMedial:(NSString *)socialMedial{
//    
//    NSURL *url = [NSURL URLWithString:@"http://yashco.info/odbaseapi/index.php/user/"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    NSString *param = [NSString stringWithFormat:@"method=registration&email=%@&password=12345&registerType=TW&userType=seekar&latitude=33.333333&longitude=22.222222&firstName=%@&lastName=%@&dob=%@&profileImage=&facebookToken=%@&twitterToken=%@&linkedinToken=%@",email,firstName,lastName,nil,nil,nil,nil];
//    
//    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLSession *session = [NSURLSession   sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        UseInfo *userInfo = [UseInfo parseUserInfoData:dic];
//    
//        
//        NSLog(@"dic=%@",dic);
//        NSLog(@"userInfo=%@",userInfo);
//    }];
//    
//    [task resume];
//    
//    NSLog(@"_userId=%@",_userId);
//    
//        return _userId;
//    
//}

@end
