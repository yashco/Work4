//
//  getJobs.h
//  Works2
//
//  Created by OD BASE 1 on 30/7/15.
//  Copyright (c) 2015 OD BASE 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetJobs : NSObject


@property(nonatomic,strong)NSArray *jobs;

@property(nonatomic,strong)NSString *jobId;

//this is a url for dowmload a company_logo image
@property(nonatomic,strong)NSString *company_logo;
@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *jobTitle;

//work short description
@property(nonatomic,strong)NSString *jobShortDescription;
@property(nonatomic,strong)NSString *jobLongDescription;

//what is the jobseeker condition now
//jobEmployment
@property(nonatomic,strong)NSString *jobType;

// which days to work every week

@property(nonatomic,strong)NSString *jobLocation;
@property(nonatomic,strong)NSString *jobLocationLatitude;
@property(nonatomic,strong)NSString *jobLocationLongitude;

//the hire time, such as long term
@property(nonatomic,strong)NSString *term;
@property(nonatomic,strong)NSString *sector;
//the extras welfare
@property(nonatomic,strong)NSString *extras;

//not available
@property(nonatomic,strong)NSString *jobGeneralVideo;

@property(nonatomic,strong)NSString *days;
@property(nonatomic,strong)NSString *employerId;
@property(nonatomic,strong)NSString *employerEmail;

@property(nonatomic,strong)NSString *requiredSkills;

@property(nonatomic,strong)NSString *minimumSalary;
@property(nonatomic,strong)NSString *maximumSalary ;

@property(nonatomic,strong)NSString *minimumHourlySalary ;
@property(nonatomic,strong)NSString *maximumHourlySalary ;

@property(nonatomic,strong)NSString *requiredMinimumExp ;
@property(nonatomic,strong)NSString *requiredMaximumExp;
@property(nonatomic,strong)NSString *requiredMinimumEducation;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *tcreateDate;

+(id)parseGetJobsInfoData:(NSDictionary *)dataDic;
+(id)parseJobsInfoData:(NSDictionary *)dataDic;

@end
