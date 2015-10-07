//
//  JobSupportViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobSupportViewController.h"
#import "RESideMenu.h"

@interface JobSupportViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    UITextField *toEmailTxt;
    UITextField *copyTxt;
    UITextField *subjectTxt;
    UITextView  *contentTView;
}
@end

@implementation JobSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 2)];
    lineImg.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 22, 15)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTintColor:[UIColor lightGrayColor]];
    leftBtn.alpha = 1.0;
    leftBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:leftBtn];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 25)];
    titleLbl.text = @"Email Support";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];

    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 45, 30, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"sendMailBtn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sendMailBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTintColor:[UIColor lightGrayColor]];
    rightBtn.alpha = 1.0;
    rightBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:rightBtn];
    
    UILabel *toEmailLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 40, 30)];
    toEmailLbl.text = @"To:";
    toEmailLbl.textColor = [UIColor lightGrayColor];
    toEmailLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:toEmailLbl];
    
    toEmailTxt = [[UITextField alloc] initWithFrame:CGRectMake(70, 90, 200, 30)];
    toEmailTxt.delegate = self;
    toEmailTxt.placeholder = @"support@gmail.com";
    toEmailTxt.backgroundColor = [UIColor clearColor];
    toEmailTxt.textColor = [UIColor blackColor];
    toEmailTxt.enabled = NO;
    [toEmailTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:toEmailTxt];
    
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 90, 25, 25)];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"plusBtn.png"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plusBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn setTintColor:[UIColor lightGrayColor]];
    plusBtn.alpha = 1.0;
    plusBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:plusBtn];
    
    UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 1)];
    lineImg1.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg1];
    
    UILabel *copyLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 60, 30)];
    copyLbl.text = @"Copy:";
    copyLbl.textColor = [UIColor lightGrayColor];
    copyLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:copyLbl];
    
    copyTxt = [[UITextField alloc] initWithFrame:CGRectMake(90, 150, 200, 30)];
    copyTxt.delegate = self;
    copyTxt.backgroundColor = [UIColor clearColor];
    copyTxt.textColor = [UIColor blackColor];
    [copyTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:copyTxt];
    
    UIImageView *lineImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 1)];
    lineImg2.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg2];
    
    UILabel *subjectLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 80, 30)];
    subjectLbl.text = @"Subject:";
    subjectLbl.textColor = [UIColor lightGrayColor];
    subjectLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subjectLbl];
    
    subjectTxt = [[UITextField alloc] initWithFrame:CGRectMake(110, 210, 200, 30)];
    subjectTxt.delegate = self;
    subjectTxt.backgroundColor = [UIColor clearColor];
    subjectTxt.textColor = [UIColor blackColor];
    [subjectTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:subjectTxt];
    
    UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 1)];
    lineImg3.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg3];
}

- (void)sendMailBtnClicked{
    
}

- (void)plusBtnClicked{
    
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
