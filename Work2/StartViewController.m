//
//  StartViewController.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "StartViewController.h"
#import "SignUpViewController.h"
#import "LogInViewController.h"
#include "AppConstant.h"

@interface StartViewController (){
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backImg.image = [UIImage imageNamed:@"2 Intro.png"];
    [self.view addSubview:backImg];

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 210, 200, 40)];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"jobseekerBtn.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTintColor:[UIColor lightGrayColor]];
    loginBtn.alpha = 1.0;
    loginBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:loginBtn];
    
    UIButton *jobseekerBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 150, 200, 40)];
    [jobseekerBtn setTitle:@"Jobseeker" forState:UIControlStateNormal];
    [jobseekerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jobseekerBtn setBackgroundImage:[UIImage imageNamed:@"jobseekerBtn.png"] forState:UIControlStateNormal];
    [jobseekerBtn addTarget:self action:@selector(jobseekerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [jobseekerBtn setTintColor:[UIColor lightGrayColor]];
    jobseekerBtn.alpha = 1.0;
    jobseekerBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:jobseekerBtn];
    
    UIButton *recruiterBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, self.view.frame.size.height - 90, 200, 40)];
    [recruiterBtn setTitle:@"Recruiter" forState:UIControlStateNormal];
    [recruiterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recruiterBtn setBackgroundImage:[UIImage imageNamed:@"recruiterBtn.png"] forState:UIControlStateNormal];
    [recruiterBtn addTarget:self action:@selector(recruiterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [recruiterBtn setTintColor:[UIColor lightGrayColor]];
    recruiterBtn.alpha = 1.0;
    recruiterBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:recruiterBtn];
}

- (void)loginBtnBtnClicked{

    LogInViewController *clientSignupView = [[LogInViewController alloc] init];
    clientSignupView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:clientSignupView animated:YES completion:nil];
}
- (void)jobseekerBtnClicked{
    SignUpViewController *jobSignupView = [[SignUpViewController alloc] initWithUserType:JOBSEEKER];
    jobSignupView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:jobSignupView animated:YES completion:nil];
}

- (void)recruiterBtnClicked{
    
    SignUpViewController *jobSignupView = [[SignUpViewController alloc] initWithUserType:RECRUITER];
    jobSignupView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:jobSignupView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
