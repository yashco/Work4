//
//  FilterInfo.h
//  Works2
//
//  Created by OD BASE 1 on 17/9/15.
//  Copyright (c) 2015 OD BASE 1. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AccountFilterPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountFilter.plist"]
@interface FilterInfo : NSObject

@property(nonatomic,strong)NSString *choosedLocation;
@property(nonatomic,strong)NSString *choosedSector;
@property(nonatomic,strong)NSString *choosedHourSalary;
@property(nonatomic,strong)NSString *choosedDistance;
@property(nonatomic,strong)NSString *choosedSalaryEXP;
@property(nonatomic,strong)NSDictionary *choosedTime;
@property(nonatomic,strong)NSString *choosedDays;
@property(nonatomic,strong)NSString *choosedTerm;
@property(nonatomic,strong)NSString *choosedExtras;

@end
