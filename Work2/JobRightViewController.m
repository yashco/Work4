//
//  JobRightViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobRightViewController.h"

@interface JobRightViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *listTable;
    UISlider    *distanceSlider;
}
@end

@implementation JobRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    UILabel *filterLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 100, 35)];
    filterLbl.text = @"FILTERS";
    filterLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [filterLbl setFont:[UIFont systemFontOfSize:20.0]];
    filterLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:filterLbl];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(120, 80, self.view.frame.size.width - 140, self.view.frame.size.height - 140) style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.scrollEnabled = NO;
    [listTable setBackgroundColor:[UIColor clearColor]];
    listTable.userInteractionEnabled=YES;
    [listTable setAllowsSelection:YES];
    if ([listTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
    
    UIButton *defaultBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, self.view.frame.size.height - 55, self.view.frame.size.width - 140, (self.view.frame.size.width - 140)/6)];
    [defaultBtn setTitle:@"Back to Default Settings" forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [defaultBtn setFont:[UIFont systemFontOfSize:13.0]];
    [defaultBtn setBackgroundImage:[UIImage imageNamed:@"clearBtn.png"] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(defaultBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [defaultBtn setTintColor:[UIColor lightGrayColor]];
    defaultBtn.alpha = 1.0;
    defaultBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:defaultBtn];
}

#pragma mark - tableViewDelegate
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
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
        UILabel *locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        locationLbl.text = @"Location";
        locationLbl.textColor = [UIColor blackColor];
        [locationLbl setFont:[UIFont systemFontOfSize:13.0]];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:locationLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 5, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(changeLocation:) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        goBtn1.tag = 0;
        
        [cell.contentView addSubview:goBtn1];
    }
    
    if (indexPath.row == 1) {
        UILabel *sectorLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        sectorLbl.text = @"Sector";
        sectorLbl.textColor = [UIColor blackColor];
        [sectorLbl setFont:[UIFont systemFontOfSize:13.0]];
        sectorLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:sectorLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 5, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn1];
    }
    
    if (indexPath.row == 2) {
        UILabel *salaryPerLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        salaryPerLbl.text = @"Salary per hour";
        salaryPerLbl.textColor = [UIColor blackColor];
        [salaryPerLbl setFont:[UIFont systemFontOfSize:13.0]];
        salaryPerLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:salaryPerLbl];
        
        UIButton *perBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(-10, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn1 setTitle:@"0 - 8" forState:UIControlStateNormal];
        [perBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn1.layer.cornerRadius = 10;
        perBtn1.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn1.layer.borderWidth = 1;
        perBtn1.layer.masksToBounds = YES;
        [perBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn1 setTintColor:[UIColor lightGrayColor]];
        perBtn1.alpha = 1.0;
        perBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn1 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn1];
        
        UIButton *perBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn1.frame.origin.x + perBtn1.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn2 setTitle:@"8 - 15" forState:UIControlStateNormal];
        [perBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn2.layer.cornerRadius = 10;
        perBtn2.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn2.layer.borderWidth = 1;
        perBtn2.layer.masksToBounds = YES;
        [perBtn2 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn2 setTintColor:[UIColor lightGrayColor]];
        perBtn2.alpha = 1.0;
        perBtn2.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn2 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn2];
        
        UIButton *perBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn2.frame.origin.x + perBtn2.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn3 setTitle:@"15 - 50" forState:UIControlStateNormal];
        [perBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn3.layer.cornerRadius = 10;
        perBtn3.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn3.layer.borderWidth = 1;
        perBtn3.layer.masksToBounds = YES;
        [perBtn3 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn3 setTintColor:[UIColor lightGrayColor]];
        perBtn3.alpha = 1.0;
        perBtn3.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn3 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn3];
        
        UIButton *perBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn3.frame.origin.x + perBtn3.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn4 setTitle:@"50+" forState:UIControlStateNormal];
        [perBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn4.layer.cornerRadius = 10;
        perBtn4.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn4.layer.borderWidth = 1;
        perBtn4.layer.masksToBounds = YES;
        [perBtn4 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn4 setTintColor:[UIColor lightGrayColor]];
        perBtn4.alpha = 1.0;
        perBtn4.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn4 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn4];
    }
    
    if (indexPath.row == 3) {
        UILabel *salaryExpLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        salaryExpLbl.text = @"Salary expectations";
        salaryExpLbl.textColor = [UIColor blackColor];
        [salaryExpLbl setFont:[UIFont systemFontOfSize:13.0]];
        salaryExpLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:salaryExpLbl];
        
        UIButton *perBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(-10, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn1 setTitle:@"0-20k" forState:UIControlStateNormal];
        [perBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn1.layer.cornerRadius = 10;
        perBtn1.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn1.layer.borderWidth = 1;
        perBtn1.layer.masksToBounds = YES;
        [perBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn1 setTintColor:[UIColor lightGrayColor]];
        perBtn1.alpha = 1.0;
        perBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn1 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn1];
        
        UIButton *perBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn1.frame.origin.x + perBtn1.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn2 setTitle:@"20k-35k" forState:UIControlStateNormal];
        [perBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn2.layer.cornerRadius = 10;
        perBtn2.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn2.layer.borderWidth = 1;
        perBtn2.layer.masksToBounds = YES;
        [perBtn2 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn2 setTintColor:[UIColor lightGrayColor]];
        perBtn2.alpha = 1.0;
        perBtn2.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn2 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn2];
        
        UIButton *perBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn2.frame.origin.x + perBtn2.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn3 setTitle:@"35k-55k" forState:UIControlStateNormal];
        [perBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn3.layer.cornerRadius = 10;
        perBtn3.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn3.layer.borderWidth = 1;
        perBtn3.layer.masksToBounds = YES;
        [perBtn3 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn3 setTintColor:[UIColor lightGrayColor]];
        perBtn3.alpha = 1.0;
        perBtn3.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn3 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn3];
        
        UIButton *perBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(perBtn3.frame.origin.x + perBtn3.frame.size.width, 40, (self.view.frame.size.width - 130)/4 - 10, 30)];
        [perBtn4 setTitle:@"55k+" forState:UIControlStateNormal];
        [perBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        perBtn4.layer.cornerRadius = 10;
        perBtn4.layer.borderColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor;
        perBtn4.layer.borderWidth = 1;
        perBtn4.layer.masksToBounds = YES;
        [perBtn4 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [perBtn4 setTintColor:[UIColor lightGrayColor]];
        perBtn4.alpha = 1.0;
        perBtn4.transform = CGAffineTransformMakeTranslation(10, 0);
        [perBtn4 setFont:[UIFont systemFontOfSize:9.0]];
        [cell.contentView addSubview:perBtn4];
    }
    
    if (indexPath.row == 4) {
        UILabel *distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        distanceLbl.text = @"Distance from job location";
        distanceLbl.textColor = [UIColor blackColor];
        [distanceLbl setFont:[UIFont systemFontOfSize:13.0]];
        distanceLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:distanceLbl];
        
        distanceSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width - 130, 20)];
        distanceSlider.minimumValue = 0.0f;
        distanceSlider.maximumValue = 50.0f;
        distanceSlider.value = 20.0f;
        [distanceSlider setContinuous:FALSE];
        [distanceSlider setTintColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0]];
        [distanceSlider addTarget:self action:@selector(getSliderValue:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:distanceSlider];
        
        UILabel *dis_minLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 20, 15)];
        dis_minLbl.text = @"0";
        dis_minLbl.textColor = [UIColor blackColor];
        [dis_minLbl setFont:[UIFont systemFontOfSize:12.0]];
        dis_minLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:dis_minLbl];
        
        UILabel *dis_maxLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130 - 50, 55, 40, 15)];
        dis_maxLbl.text = @"100km";
        dis_maxLbl.textColor = [UIColor blackColor];
        [dis_maxLbl setFont:[UIFont systemFontOfSize:12.0]];
        dis_maxLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:dis_maxLbl];
    }
    
    if (indexPath.row == 5) {
        UILabel *fulltimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        fulltimeLbl.text = @"Fulltime";
        fulltimeLbl.textColor = [UIColor blackColor];
        [fulltimeLbl setFont:[UIFont systemFontOfSize:13.0]];
        fulltimeLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:fulltimeLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 5, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn1];
    }
    
    if (indexPath.row == 6) {
        UILabel *daysLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        daysLbl.text = @"Days:";
        daysLbl.textColor = [UIColor blackColor];
        [daysLbl setFont:[UIFont systemFontOfSize:13.0]];
        daysLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:daysLbl];
    }
    
    if (indexPath.row == 7) {
        UILabel *durationLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        durationLbl.text = @"Duration: Long term";
        durationLbl.textColor = [UIColor blackColor];
        [durationLbl setFont:[UIFont systemFontOfSize:13.0]];
        durationLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:durationLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 5, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn1];
    }
    
    if (indexPath.row == 8) {
        UILabel *extraLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        extraLbl.text = @"Extra";
        extraLbl.textColor = [UIColor blackColor];
        [extraLbl setFont:[UIFont systemFontOfSize:13.0]];
        extraLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:extraLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 5, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn1];
    }
    
    return cell;
}

- (void)goBtn1Clicked{
    
    
}

- (void)getSliderValue:(UISlider *)param{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Height of the rows
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8) {
        return 30;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)defaultBtnClicked{
    
    
    
    
    
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
