//
//  JobNotyViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobNotyViewController.h"
#import "RESideMenu.h"

#import "YSLContainerViewController.h"

#import "JobAllNotyViewController.h"
#import "JobChaViewController.h"
#import "JobMatchNotyViewController.h"
#import "JobRequestViewController.h"

@interface JobNotyViewController ()<YSLContainerViewControllerDelegate>
{

}
@end

@implementation JobNotyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // SetUp ViewControllers
    JobAllNotyViewController *allVC = [[JobAllNotyViewController alloc] init];
    allVC.title = @"All";
    
    JobMatchNotyViewController *matchVC = [[JobMatchNotyViewController alloc] init];
    matchVC.title = @"Matches";
    
    JobChaViewController *chaVC = [[JobChaViewController alloc] init];
    chaVC.title = @"Cha";
    
    JobRequestViewController *requestVC = [[JobRequestViewController alloc] init];
    requestVC.title = @"Requests";
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc] initWithControllers:@[allVC,matchVC,chaVC,requestVC]
                                                                                         topBarHeight:statusHeight + navigationHeight
                                                                                 parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:containerVC.view];
    
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
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Notification";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
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
