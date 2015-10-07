//
//  JobMatchNotyViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobMatchNotyViewController.h"

@interface JobMatchNotyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *matchTable;
    NSMutableArray *matchArray;
}
@end

@implementation JobMatchNotyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    matchArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    matchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 110) style:UITableViewStylePlain];
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
    return 4;
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
    
    UIImageView *profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    profileImg.image = [UIImage imageNamed:@"userImg.png"];
    profileImg.layer.cornerRadius = 20;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImg.layer.borderWidth = 1;
    profileImg.layer.masksToBounds = YES;
    [cell.contentView addSubview:profileImg];
    
    UILabel *userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(profileImg.frame.origin.x + profileImg.frame.size.width + 10, 10, 150, 20)];
    userNameLbl.text = @"Linda Robbe";
    userNameLbl.font = [UIFont systemFontOfSize:15.0];
    userNameLbl.textAlignment = NSTextAlignmentLeft;
    userNameLbl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [cell.contentView addSubview:userNameLbl];
    
    UILabel *userInfo = [[UILabel alloc] initWithFrame:CGRectMake(profileImg.frame.origin.x + profileImg.frame.size.width + 10, 30, 150, 20)];
    userInfo.text = @"manager";
    userInfo.font = [UIFont systemFontOfSize:13.0];
    userInfo.textAlignment = NSTextAlignmentLeft;
    userInfo.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [cell.contentView addSubview:userInfo];
    
    UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 10, 90, 20)];
    timeLbl.text = @"2mins ago";
    timeLbl.font = [UIFont systemFontOfSize:13.0];
    timeLbl.textAlignment = NSTextAlignmentCenter;
    timeLbl.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1.0];
    [cell.contentView addSubview:timeLbl];
    
    UIImageView *onlineImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, 35, 10, 10)];
    onlineImg.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    onlineImg.layer.cornerRadius = 5;
    onlineImg.layer.masksToBounds = YES;
    [cell.contentView addSubview:onlineImg];
    
    UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, self.view.frame.size.width, 1)];
    lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    [cell.contentView addSubview:lineImg3];
    
    return cell;
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
