//
//  getJobs.m
//  Works2
//
//  Created by OD BASE 1 on 3index/7/15.
//  Copyright (c) 2index15 OD BASE 1. All rights reserved.
//

#import "GetJobs.h"


static NSString *const company_logoURLString = @"https://works-api-odbase.c9.io/includes/images/company_logo/companylogo.png";

@implementation GetJobs


+(id)parseGetJobsInfoData:(NSDictionary *)dataDic{

    return [[self alloc]initWithGetJobDic:dataDic];
     
}

-(id)initWithGetJobDic:(NSDictionary *)dataDic{
    
    if (self==[super init]) {
        
        self.jobs = dataDic[@"jobs"];
    }
    return self;
}




+(id)parseJobsInfoData:(NSDictionary *)dataDic{
    
    return [[self alloc]initWithJobDic:dataDic];
    
}

-(id)initWithJobDic:(NSDictionary *)dataDic{

    if (self==[super init]) {
        
        NSURL *url = dataDic[@"company_logo"];
        self.company_logo = [self imageMap][url];
        
        self.jobId = dataDic[@"jobId"];
        self.company_name = dataDic[@"company_name"];
        self.jobTitle = dataDic[@"jobTitle"];
        self.jobShortDescription = dataDic[@"jobShortDescription"];
        self.jobType = dataDic[@"jobType"];
        self.jobLocation = dataDic[@"jobLocation"];
        
//        self.jobGeneralVideo = dataDic[@"jobGeneralVideo"];
        self.jobLocationLatitude = dataDic[@"jobLocationLatitude"];
        self.jobLocationLongitude = dataDic[@"jobLocationLongitude"];
        self.jobLongDescription = dataDic[@"jobLongDescription"];
        self.employerId = dataDic[@"employerId"];
        self.employerEmail = dataDic[@"employerEmail"];
        self.requiredSkills = dataDic[@"requiredSkills"];
        self.term = dataDic[@"term"];
        
        self.sector = dataDic[@"sector"];
        self.days = dataDic[@"days"];
        self.minimumSalary = dataDic[@"minimumSalary"];
        self.maximumSalary = dataDic[@"maximumSalary"];
        
        self.minimumHourlySalary = dataDic[@"minimumHourlySalary"];
        self.maximumHourlySalary = dataDic[@"maximumHourlySalary"];
        self.extras = dataDic[@"extras"];
        self.requiredMinimumExp = dataDic[@"requiredMinimumExp"];
        self.requiredMaximumExp = dataDic[@"requiredMaximumExp"];
        
        self.requiredMinimumEducation = dataDic[@"requiredMinimumEducation"];
        self.status = dataDic[@"status"];
        self.tcreateDate = dataDic[@"tcreateDate"];
        
    }
    return self;
}




-(NSDictionary *)imageMap{
    
    return @{[NSString stringWithFormat:@"%@",company_logoURLString]:@"company_logo.png"};
}
@end
