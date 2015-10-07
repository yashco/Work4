//
//  JobKeyViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobKeyViewController.h"
#import "AddKeyViewController.h"

@interface JobKeyViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView    *keywordTable;
    
    NSMutableArray *keywordsArray;
    NSMutableArray *descArray;
    
    UIView         *searchView;
    UITextField    *searchText;
    
    UILabel        *description;
}
@end

@implementation JobKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    keywordsArray    = [NSMutableArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", nil];
    descArray        = [NSMutableArray arrayWithObjects:@"aaaaaaaa", @"bbbbbbbbb", @"ccccccccc", @"ddddddddd", @"eeeeeeeee", @"ffffffffff", nil];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 2)];
    lineImg.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 27, 12, 20)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTintColor:[UIColor lightGrayColor]];
    backBtn.alpha = 1.0;
    backBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:backBtn];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Profile keywords";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UIButton *addKeyBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, 15, 40, 40)];
    [addKeyBtn setTitle:@"Add" forState:UIControlStateNormal];
    addKeyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [addKeyBtn setTitleColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [addKeyBtn addTarget:self action:@selector(addKeyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [addKeyBtn setTintColor:[UIColor lightGrayColor]];
    addKeyBtn.alpha = 1.0;
    addKeyBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:addKeyBtn];
    
    searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, 60)];
    searchView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    searchView.layer.borderColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0].CGColor;
    searchView.layer.borderWidth = 1;
    searchView.layer.masksToBounds = YES;
    
    UIImageView *searchBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 220, 40)];
    searchBackImg.image = [UIImage imageNamed:@"searchBack.png"];
    [searchView addSubview:searchBackImg];
    
    UIImageView *searchIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 20, 20)];
    searchIconImg.image = [UIImage imageNamed:@"searchIcon.png"];
    [searchView addSubview:searchIconImg];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(60, 15, 150, 30)];
    searchText.delegate = self;
    searchText.placeholder = @"search...";
    searchText.backgroundColor = [UIColor clearColor];
    searchText.textColor = [UIColor blackColor];
    searchText.font = [UIFont systemFontOfSize:16];
    [searchText setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchText.keyboardType = UIKeyboardTypeAlphabet;
    [searchView addSubview:searchText];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 10, 50, 40)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [cancelBtn setTitleColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTintColor:[UIColor lightGrayColor]];
    cancelBtn.alpha = 1.0;
    cancelBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [searchView addSubview:cancelBtn];
    
    [self.view addSubview:searchView];
    
    keywordTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 132, self.view.frame.size.width, self.view.frame.size.height - 132 - 150) style:UITableViewStylePlain];
    keywordTable.dataSource = self;
    keywordTable.delegate = self;
    [keywordTable setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    keywordTable.userInteractionEnabled=YES;
    [keywordTable setAllowsSelection:YES];
    if ([keywordTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [keywordTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [keywordTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:keywordTable];
    
    UILabel *declbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 25)];
    declbl.text = @"Description for this keyword";
    declbl.font = [UIFont systemFontOfSize:15.0];
    declbl.textAlignment = NSTextAlignmentCenter;
    declbl.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    declbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:declbl];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 125, self.view.frame.size.width, 130)];
    backView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    backView.layer.borderColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0].CGColor;
    backView.layer.borderWidth = 1;
    backView.layer.masksToBounds = YES;
    [self.view addSubview:backView];
    
    description = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 120, self.view.frame.size.width - 40, 125)];
    description.font = [UIFont systemFontOfSize:15.0];
    description.textAlignment = NSTextAlignmentLeft;
    description.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    description.numberOfLines = 10;
    [self.view addSubview:description];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return keywordsArray.count;
}

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
    
    UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width - 30, 20)];
    clientNameLbl.text = [keywordsArray objectAtIndex:indexPath.row];
    clientNameLbl.font = [UIFont systemFontOfSize:15.0];
    clientNameLbl.textAlignment = NSTextAlignmentLeft;
    clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    [cell.contentView addSubview:clientNameLbl];
    
    UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, self.view.frame.size.width, 1)];
    lineImg3.backgroundColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    [cell.contentView addSubview:lineImg3];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Height of the rows
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *desc = [descArray objectAtIndex:indexPath.row];
    description.text = desc;
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addKeyBtnClicked{
    AddKeyViewController *addview = [[AddKeyViewController alloc] init];
    [self.navigationController pushViewController:addview animated:YES];
}

- (void)cancelBtnClicked{
    [searchText resignFirstResponder];
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
