//
//  JobLeftViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobLeftViewController.h"
#import "AppDelegate.h"
#import "JobMainViewController.h"
#import "JobNotyViewController.h"
#import "JobSupportViewController.h"
#import "JobFeedbackViewController.h"
#import "JobSettingViewController.h"
#import "JobMatchViewController.h"
#import "JobMapViewController.h"
#import "JobAboutViewController.h"
#import "JobAccountViewController.h"
#import "UIImageView+WebCache.h"

#include "SocialNetwork.h"
#import "UseInfo.h"

@interface JobLeftViewController ()<UITableViewDataSource, UITableViewDelegate,Social>
{
    UIImageView *profileImg;
    UILabel     *userNameLbl;
    UILabel     *userInfo;
    UITableView *menuTable;
    
    NSMutableArray *listArray;
    SocialNetwork* m_pSocialNetwork;
    
}
@end

@implementation JobLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pSocialNetwork = [[SocialNetwork alloc] initWithDeleget:self];
    listArray = [NSMutableArray arrayWithObjects:@"Home Screen", @"Match overview", @"Notifications", @"Mapview", @"Account", @"About", @"Settings", @"Support", @"Feedback", nil];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 80, 80)];
   
    //[profileImg sd_setImageWithURL:[NSURL URLWithString:@"https://scontent.xx.fbcdn.net/hprofile-ash2/v/t1.0-1/p100x100/10923495_1535072930111935_7044047763373130386_n.jpg?oh=8d9bf17d2214fd383e990c417d34b89b&oe=56694B9D"] placeholderImage: profileImg.image = [UIImage imageNamed:@"userImg.png"]];
    UseInfo *user = [[UseInfo alloc]init];
     user = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    [profileImg sd_setImageWithURL:[NSURL URLWithString:user.imageUrl] placeholderImage:[UIImage imageNamed:@"userImg.png"]];
    
    profileImg.layer.cornerRadius = 40;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImg.layer.borderWidth = 1;
    profileImg.layer.masksToBounds = YES;
    [self.view addSubview:profileImg];
    
    userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(profileImg.frame.origin.x + profileImg.frame.size.width + 10, 30, 150, 20)];
    userNameLbl.text = user.first_name;
    
    userNameLbl.font = [UIFont boldSystemFontOfSize:18.0];
    userNameLbl.textAlignment = NSTextAlignmentLeft;
    userNameLbl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [self.view addSubview:userNameLbl];
    
    userInfo = [[UILabel alloc] initWithFrame:CGRectMake(profileImg.frame.origin.x + profileImg.frame.size.width + 10, 50, self.view.frame.size.width - 130, 60)];
    userInfo.text = @"asdfasdfasdfasdfsdfasdfasdfasdfasdf";
    userInfo.font = [UIFont systemFontOfSize:13.0];
    userInfo.textAlignment = NSTextAlignmentLeft;
    userInfo.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    userInfo.numberOfLines = 5;
    [self.view addSubview:userInfo];
    
    UIButton *logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 30, 60, 20)];
    [logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtnnClicked) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTintColor:[UIColor lightGrayColor]];
    logoutBtn.alpha = 1.0;
    logoutBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:logoutBtn];
    
    UILabel *menuLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, profileImg.frame.origin.y + profileImg.frame.size.height + 10, 60, 25)];
    menuLbl.text = @"Menu";
    menuLbl.font = [UIFont boldSystemFontOfSize:20.0];
    menuLbl.textAlignment = NSTextAlignmentLeft;
    menuLbl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [self.view addSubview:menuLbl];
    
    menuTable = [[UITableView alloc] initWithFrame:CGRectMake(0, menuLbl.frame.origin.y + menuLbl.frame.size.height + 10, self.view.frame.size.width, self.view.frame.size.height - (menuLbl.frame.origin.y + menuLbl.frame.size.height + 10 + 60))];
    menuTable.dataSource = self;
    menuTable.delegate = self;
    [menuTable setBackgroundColor:[UIColor clearColor]];
    menuTable.userInteractionEnabled=YES;
    [menuTable setAllowsSelection:YES];
    menuTable.scrollEnabled = NO;
    if ([menuTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [menuTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:menuTable];
    
    UIButton *rateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 45, 40, 30)];
    [rateBtn setBackgroundImage:[UIImage imageNamed:@"rateBtn.png"] forState:UIControlStateNormal];
    [rateBtn addTarget:self action:@selector(rateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rateBtn setTintColor:[UIColor lightGrayColor]];
    rateBtn.alpha = 1.0;
    rateBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:rateBtn];
    
    UILabel *shareOnLbl = [[UILabel alloc] initWithFrame:CGRectMake(rateBtn.frame.size.width + 10 + 50, self.view.frame.size.height - 45, 80, 30)];
    shareOnLbl.text = @"Share on:";
    shareOnLbl.textColor = [UIColor lightGrayColor];
    [shareOnLbl setFont:[UIFont systemFontOfSize:15.0]];
    shareOnLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shareOnLbl];
    
    UIButton *linkedinBtn = [[UIButton alloc] initWithFrame:CGRectMake(shareOnLbl.frame.origin.x + shareOnLbl.frame.size.width + 2, self.view.frame.size.height - 45, 30, 30)];
    [linkedinBtn setBackgroundImage:[UIImage imageNamed:@"Linkedin.png"] forState:UIControlStateNormal];
    [linkedinBtn addTarget:self action:@selector(linkedinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [linkedinBtn setTintColor:[UIColor lightGrayColor]];
    linkedinBtn.alpha = 1.0;
    linkedinBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:linkedinBtn];
    
    UIButton *facebookBtn = [[UIButton alloc] initWithFrame:CGRectMake(linkedinBtn.frame.origin.x + linkedinBtn.frame.size.width + 2, self.view.frame.size.height - 45, 30, 30)];
    [facebookBtn setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(facebookBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [facebookBtn setTintColor:[UIColor lightGrayColor]];
    facebookBtn.alpha = 1.0;
    facebookBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:facebookBtn];
    
    UIButton *twitterBtn = [[UIButton alloc] initWithFrame:CGRectMake(facebookBtn.frame.origin.x + facebookBtn.frame.size.width + 2, self.view.frame.size.height - 45, 30, 30)];
    [twitterBtn setBackgroundImage:[UIImage imageNamed:@"Twitter.png"] forState:UIControlStateNormal];
    [twitterBtn addTarget:self action:@selector(twitterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [twitterBtn setTintColor:[UIColor lightGrayColor]];
    twitterBtn.alpha = 1.0;
    twitterBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:twitterBtn];
}

- (void)linkedinBtnClicked{
    
}

- (void)facebookBtnClicked{
    
}

- (void)twitterBtnClicked{
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    else{
        UIView *subview;
        while ((subview= [[[cell contentView]subviews]lastObject])!=nil)
            [subview removeFromSuperview];
    }
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, self.view.frame.size.width - 40, 24)];
    lbl.text = [listArray objectAtIndex:indexPath.row];
    lbl.font = [UIFont systemFontOfSize:16.0];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [cell.contentView addSubview:lbl];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        JobMainViewController *mainView = [[JobMainViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 1) {
        JobMatchViewController *mainView = [[JobMatchViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 2) {
        JobNotyViewController *mainView = [[JobNotyViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 3) {
        JobMapViewController *mainView = [[JobMapViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 4) {
        JobAccountViewController *mainView = [[JobAccountViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 5) {
        JobAboutViewController *mainView = [[JobAboutViewController alloc] initWithNibName:@"JobAboutViewController" bundle:nil];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 6) {
        JobSettingViewController *mainView = [[JobSettingViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 7) {
        JobSupportViewController *mainView = [[JobSupportViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 8) {
        JobFeedbackViewController *mainView = [[JobFeedbackViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainView];
        navi.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:navi animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
}

- (void)rateBtnClicked{
    
}

- (void)logoutBtnnClicked{
    [m_pSocialNetwork logOutFromAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----CallBackFromSocialNetwork-----
//-(void)alreadyLoginwith:(LogInWith)name islogin:(BOOL)isLogin{
//
//}
//-(void)logInWith:(LogInWith)name islogin:(BOOL) islogin{
//
//}
//-(void)fetchUserInfoFrom:(LogInWith)name isfetched:(BOOL)fetched userinfo:(UseInfo*) usrinfo{
//    
//}
-(void)logOutFromAll{
        [[AppDelegate sharedAppDelegate] initStart];
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
