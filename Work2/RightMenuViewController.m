//
//  RightMenuViewController.m
//  Work2
//
//  Created by topone on 9/3/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "RightMenuViewController.h"

@interface RightMenuViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *listTable;
    UISwitch    *switch_ctrl;
    UISlider    *yearSlider;
    UISlider    *distanceSlider;
}

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    UILabel *filterLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 100, 35)];
    filterLbl.text = @"FILTERS";
    filterLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [filterLbl setFont:[UIFont systemFontOfSize:22.0]];
    filterLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:filterLbl];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(120, 80, self.view.frame.size.width - 140, self.view.frame.size.height - 160) style:UITableViewStylePlain];
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
    
    UIButton *clearAllFilterBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, self.view.frame.size.height - 90, (self.view.frame.size.width - 160)/2, (self.view.frame.size.width - 160)/10)];
    [clearAllFilterBtn setTitle:@"Clear Filters" forState:UIControlStateNormal];
    [clearAllFilterBtn setFont:[UIFont systemFontOfSize:10.0]];
    [clearAllFilterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearAllFilterBtn setBackgroundImage:[UIImage imageNamed:@"clearAllBtn.png"] forState:UIControlStateNormal];
    [clearAllFilterBtn addTarget:self action:@selector(clearAllFilterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [clearAllFilterBtn setTintColor:[UIColor lightGrayColor]];
    clearAllFilterBtn.alpha = 1.0;
    clearAllFilterBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:clearAllFilterBtn];
    
    UIButton *changeLayBtn = [[UIButton alloc] initWithFrame:CGRectMake(130 + (self.view.frame.size.width - 160)/2, self.view.frame.size.height - 90, (self.view.frame.size.width - 160)/2, (self.view.frame.size.width - 160)/10)];
    [changeLayBtn setTitle:@"Change Layout" forState:UIControlStateNormal];
    [changeLayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [changeLayBtn setFont:[UIFont systemFontOfSize:10.0]];
    [changeLayBtn setBackgroundImage:[UIImage imageNamed:@"clearAllBtn.png"] forState:UIControlStateNormal];
    [changeLayBtn addTarget:self action:@selector(changeLayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [changeLayBtn setTintColor:[UIColor lightGrayColor]];
    changeLayBtn.alpha = 1.0;
    changeLayBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:changeLayBtn];
    
    UIButton *advancedBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, self.view.frame.size.height - 60, self.view.frame.size.width - 140, (self.view.frame.size.width - 140)/6)];
    [advancedBtn setTitle:@"Advanced Settings" forState:UIControlStateNormal];
    [advancedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [advancedBtn setFont:[UIFont systemFontOfSize:11.0]];
    [advancedBtn setBackgroundImage:[UIImage imageNamed:@"clearBtn.png"] forState:UIControlStateNormal];
    [advancedBtn addTarget:self action:@selector(advancedBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [advancedBtn setTintColor:[UIColor lightGrayColor]];
    advancedBtn.alpha = 1.0;
    advancedBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:advancedBtn];
}

- (void)clearAllFilterBtnClicked{
    
}

- (void)changeLayBtnClicked{
    
}

- (void)advancedBtnClicked{
    
}

#pragma mark - tableViewDelegate
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
        UILabel *yearLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        yearLbl.text = @"Years of Experience";
        yearLbl.textColor = [UIColor blackColor];
        [yearLbl setFont:[UIFont systemFontOfSize:13.0]];
        yearLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:yearLbl];
        
        yearSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width - 130, 20)];
        yearSlider.minimumValue = 0.0f;
        yearSlider.maximumValue = 50.0f;
        yearSlider.value = 20.0f;
        [yearSlider setContinuous:FALSE];
        [yearSlider addTarget:self action:@selector(getSliderValue:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:yearSlider];
        
        UILabel *minLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 20, 15)];
        minLbl.text = @"0";
        minLbl.textColor = [UIColor blackColor];
        [minLbl setFont:[UIFont systemFontOfSize:12.0]];
        minLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:minLbl];
        
        UILabel *maxLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130 - 30, 55, 20, 15)];
        maxLbl.text = @"50";
        maxLbl.textColor = [UIColor blackColor];
        [maxLbl setFont:[UIFont systemFontOfSize:12.0]];
        maxLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:maxLbl];
    }
    
    if (indexPath.row == 1) {
        UILabel *eduLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        eduLbl.text = @"Education Level";
        eduLbl.textColor = [UIColor blackColor];
        [eduLbl setFont:[UIFont systemFontOfSize:13.0]];
        eduLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:eduLbl];
        
        UILabel *levelLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 200, 20)];
        levelLbl.text = @"Elementary School";
        levelLbl.textColor = [UIColor grayColor];
        [levelLbl setFont:[UIFont systemFontOfSize:13.0]];
        levelLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:levelLbl];
        
        UIButton *goBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 35, 10, 15)];
        [goBtn1 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn1 addTarget:self action:@selector(goBtn1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn1 setTintColor:[UIColor lightGrayColor]];
        goBtn1.alpha = 1.0;
        goBtn1.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn1];
    }
    
    if (indexPath.row == 2) {
        UILabel *keyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        keyLbl.text = @"Keywords";
        keyLbl.textColor = [UIColor blackColor];
        [keyLbl setFont:[UIFont systemFontOfSize:13.0]];
        keyLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:keyLbl];
        
        UILabel *wordLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 200, 20)];
        wordLbl.text = @"Referenced keywords only";
        wordLbl.textColor = [UIColor grayColor];
        [wordLbl setFont:[UIFont systemFontOfSize:13.0]];
        wordLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:wordLbl];
        
        UIButton *goBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 165, 35, 10, 15)];
        [goBtn2 setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [goBtn2 addTarget:self action:@selector(goBtn2Clicked) forControlEvents:UIControlEventTouchUpInside];
        [goBtn2 setTintColor:[UIColor lightGrayColor]];
        goBtn2.alpha = 1.0;
        goBtn2.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:goBtn2];
    }
    
    if (indexPath.row == 3) {
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
        [distanceSlider addTarget:self action:@selector(getSliderValue2:) forControlEvents:UIControlEventValueChanged];
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
    
    if (indexPath.row == 4) {
        UILabel *distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - 120, 20)];
        distanceLbl.text = @"Slightly variating profiles allowed";
        distanceLbl.textColor = [UIColor blackColor];
        [distanceLbl setFont:[UIFont systemFontOfSize:12.0]];
        distanceLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:distanceLbl];
        
        switch_ctrl = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 185, 40, 30, 30)];
        [switch_ctrl addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [switch_ctrl setOnTintColor:[UIColor colorWithRed:35.0/255.0 green:85.0/255.0 blue:140.0/255.0 alpha:1.0]];
        switch_ctrl.transform = CGAffineTransformMakeScale(0.75, 0.75);
        [cell.contentView addSubview:switch_ctrl];
    }
    
    return cell;
}

- (void)getSliderValue:(UISlider *)param{
    
}

- (void)getSliderValue2:(UISlider *)param{
    
}
-(void)changeLocation:(UIButton *)sender{
    if ( sender.tag ==0) {
        NSLog(@"changelocation");
    }
    
}
- (void)goBtn1Clicked{
    
}

- (void)goBtn2Clicked{
    
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
    return 80;
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
