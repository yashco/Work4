//
//  SignUpViewController.h
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

- (id)initWithUserType:(int)userType;
@property(nonatomic,retain)UIImageView *fbProfileImage;
@property(nonatomic,retain)NSString *twImageURLStr;

@end