//
//  JobMatchViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobMatchViewController.h"
#import "RESideMenu.h"

#import "JobChatViewController.h"

@interface JobMatchViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *matchTable;
}
@end

@implementation JobMatchViewController

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
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Match Overview";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    matchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 72) style:UITableViewStylePlain];
    matchTable.dataSource = self;
    matchTable.delegate = self;
    [matchTable setBackgroundColor:[UIColor clearColor]];
    matchTable.userInteractionEnabled=YES;
    [matchTable setAllowsSelection:YES];
    if ([matchTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [matchTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [matchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:matchTable];
}

#pragma mark - tableViewDelegate
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    else
    {
        UIView *subview;
        while ((subview= [[[cell contentView]subviews]lastObject])!=nil)
            [subview removeFromSuperview];
    }
    
    UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width - 30, 20)];
    clientNameLbl.text = @"Executive Manager";
    clientNameLbl.font = [UIFont systemFontOfSize:15.0];
    clientNameLbl.textAlignment = NSTextAlignmentLeft;
    clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    [cell.contentView addSubview:clientNameLbl];
    
    UILabel *clientInfo = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, self.view.frame.size.width - 30, 20)];
    clientInfo.text = @"Amsterdam";
    clientInfo.font = [UIFont systemFontOfSize:13.0];
    clientInfo.textAlignment = NSTextAlignmentLeft;
    clientInfo.textColor = [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1.0];
    [cell.contentView addSubview:clientInfo];
    
    UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 18, 22, 22)];
    [chatBtn setBackgroundImage:[UIImage imageNamed:@"messageBtn.png"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(chatBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn setTintColor:[UIColor lightGrayColor]];
    chatBtn.alpha = 1.0;
    chatBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [cell.contentView addSubview:chatBtn];
    
    UIButton *infoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, 18, 22, 22)];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"notyIcon.png"] forState:UIControlStateNormal];
    [infoBtn addTarget:self action:@selector(infoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setTintColor:[UIColor lightGrayColor]];
    infoBtn.alpha = 1.0;
    infoBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [cell.contentView addSubview:infoBtn];
    
    UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, self.view.frame.size.width, 1)];
    lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    [cell.contentView addSubview:lineImg3];
    
    return cell;
}

- (void)chatBtnclicked:(UIButton *)sender{
    JobChatViewController *chatView = [[JobChatViewController alloc] init];
    [self.navigationController pushViewController:chatView animated:YES];
}

- (void)infoBtnClicked:(UIButton *)sender{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Height of the rows
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
