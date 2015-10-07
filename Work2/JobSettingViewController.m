//
//  JobSettingViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobSettingViewController.h"
#import "RESideMenu.h"

@interface JobSettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *listTable;
    UISwitch    *profileSwitch;
    UISwitch    *metricSwitch;
    UISlider    *distanceSlider;
}
@end

@implementation JobSettingViewController

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
    titleLbl.text = @"Settings";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UILabel *searchLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, 20)];
    searchLbl.text = @"Your Default Preferences";
    searchLbl.font = [UIFont systemFontOfSize:15.0];
    searchLbl.textAlignment = NSTextAlignmentCenter;
    searchLbl.textColor = [UIColor grayColor];
    [self.view addSubview:searchLbl];
    
    UILabel *settingLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, self.view.frame.size.width - 20, 20)];
    settingLbl.text = @"General Settings";
    settingLbl.font = [UIFont systemFontOfSize:16.0];
    settingLbl.textAlignment = NSTextAlignmentLeft;
    settingLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:settingLbl];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    [listTable setBackgroundColor:[UIColor clearColor]];
    listTable.userInteractionEnabled=YES;
    [listTable setAllowsSelection:YES];
    if ([listTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
}

#pragma mark - tableViewDelegate
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
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
    
    if (indexPath.row == 0) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 20)];
        locationLbl.text = @"Slightly variating profiles allowed";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        profileSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 5, 30, 30)];
        [profileSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [profileSwitch setOnTintColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0]];
        profileSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
        [cell.contentView addSubview:profileSwitch];
    }
    
    if (indexPath.row == 1) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Imperial / Metric";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        metricSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 5, 30, 30)];
        [metricSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [metricSwitch setOnTintColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0]];
        metricSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
        [cell.contentView addSubview:metricSwitch];
    }
    
    if (indexPath.row == 2) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 20)];
        locationLbl.text = @"Standard search radius";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        distanceSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 35, self.view.frame.size.width - 40, 20)];
        distanceSlider.minimumValue = 0.0f;
        distanceSlider.maximumValue = 50.0f;
        distanceSlider.value = 20.0f;
        [distanceSlider setContinuous:FALSE];
        [distanceSlider setTintColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0]];
        [distanceSlider addTarget:self action:@selector(getSliderValue:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:distanceSlider];
    }
    
    if (indexPath.row == 8) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Days";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
    }
    
    if (indexPath.row == 4) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Location";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 5) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Sector";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 6) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Currency";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 7) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Salary";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 3) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Full time";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 9) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Availability";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 10) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Duration";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    if (indexPath.row == 11) {
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        locationLbl.text = @"Social";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:14.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIImageView *goimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 25, 5, 10, 15)];
        goimg.image = [UIImage imageNamed:@"goBtn.png"];
        [cell.contentView addSubview:goimg];
    }
    
    //cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    return cell;
}

- (void)getSliderValue:(UISlider *)param{
    
}

- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
        NSLog(@"Switch is ON");
    } else{
        // Execute any code when the switch is OFF
        NSLog(@"Switch is OFF");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Height of the rows
    if (indexPath.row == 2) {
        return 60;
    }
    return 40;
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
