//
//  FilterInfo.m
//  Works2
//
//  Created by OD BASE 1 on 17/9/15.
//  Copyright (c) 2015 OD BASE 1. All rights reserved.
//

#import "FilterInfo.h"

@implementation FilterInfo

/*
 @property(nonatomic,strong)NSString *choosedLocation;
 @property(nonatomic,strong)NSString *choosedSector;
 @property(nonatomic,strong)NSString *choosedHourSalary;
 @property(nonatomic,strong)NSString *choosedDistance;
 @property(nonatomic,strong)NSString *choosedSalaryEXP;
 @property(nonatomic,strong)NSDictionary *choosedTime;
 @property(nonatomic,strong)NSString *choosedDays;
 @property(nonatomic,strong)NSString *choosedTerm;
 @property(nonatomic,strong)NSString *choosedExtras;
 */

-(id)initWithDictionaryData:(NSDictionary *)dataDic{
    
    if (self = [super init]) {
        self.choosedLocation = dataDic[@"choosedLocation"];
        self.choosedSector = dataDic[@"choosedSector"];
        self.choosedHourSalary = dataDic[@"choosedHourSalary"];
        self.choosedDistance = dataDic[@"choosedDistance"];
        self.choosedSalaryEXP = dataDic[@"choosedSalaryEXP"];
        self.choosedTime = dataDic[@"choosedTime"];
        self.choosedDays = dataDic[@"choosedDays"];
        self.choosedTerm = dataDic[@"choosedTerm"];
        self.choosedExtras = dataDic[@"choosedExtras"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.choosedLocation forKey:@"choosedLocation"];
    [encoder encodeObject:self.choosedSector forKey:@"choosedSector"];
    [encoder encodeObject:self.choosedHourSalary forKey:@"choosedHourSalary"];
    [encoder encodeObject:self.choosedDistance forKey:@"choosedDistance"];
    [encoder encodeObject:self.choosedSalaryEXP forKey:@"choosedSalaryEXP"];
    [encoder encodeObject:self.choosedTime forKey:@"choosedTime"];
    [encoder encodeObject:self.choosedDays forKey:@"choosedDays"];
    [encoder encodeObject:self.choosedTerm forKey:@"choosedTerm"];
    [encoder encodeObject:self.choosedExtras forKey:@"choosedExtras"];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    if (self = [super init]) {
        self.choosedLocation = [decoder decodeObjectForKey:@"choosedLocation"];
        self.choosedSector = [decoder decodeObjectForKey:@"choosedSector"];
        self.choosedHourSalary = [decoder decodeObjectForKey:@"choosedHourSalary"];
        self.choosedDistance = [decoder decodeObjectForKey:@"choosedDistance"];
        self.choosedSalaryEXP = [decoder decodeObjectForKey:@"choosedSalaryEXP"];
        self.choosedTime = [decoder decodeObjectForKey:@"choosedTime"];
        self.choosedDays = [decoder decodeObjectForKey:@"choosedDays"];
        self.choosedTerm = [decoder decodeObjectForKey:@"choosedTerm"];
        self.choosedExtras = [decoder decodeObjectForKey:@"choosedExtras"];
    }
    return self;
    
}


+ (void)saveFilterInfo:(FilterInfo *)filterInfo{
    
    [NSKeyedArchiver archiveRootObject:filterInfo toFile:AccountFilterPath];
    
}


+ (FilterInfo *)filterInfo{
    
    FilterInfo *filterInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilterPath];
    
    return filterInfo;
}


+(id)parseFilterInfoData:(NSDictionary *)dataDic{
    
    return  [[self alloc]initWithDictionaryData:dataDic];
    
}



@end
