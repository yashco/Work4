//
//  JobAccountViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobAccountViewController.h"
#import "RESideMenu.h"

#import "JobKeyViewController.h"

@interface JobAccountViewController ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>
{
    UITableView     *profileTable;
    
    NSMutableArray  *headerArray;
    NSMutableArray  *keywordsArray;
    NSMutableArray  *workArray;
    NSMutableArray  *educationArray;
    NSMutableArray  *awardsArray;
    
    UITextField *headerTxt;
    UIButton *editBtn;
    BOOL isEdit;
}
@end

@implementation JobAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerArray    = [NSMutableArray arrayWithObjects:@"Profile Picture", @"Pitch", @"Profile Video", @"Keywords", @"Work experience", @"Education", @"Awards", nil];
    keywordsArray  = [NSMutableArray arrayWithObjects:@"View my keywords", @"Add referenced keywords", @"Add backed keywords", @"Add regular keywords", nil];
    workArray      = [NSMutableArray arrayWithObjects:@"View my work experience", @"Add work experience", nil];
    educationArray = [NSMutableArray arrayWithObjects:@"View my education", @"Add education", nil];
    awardsArray    = [NSMutableArray arrayWithObjects:@"View my awards", @"Add awards", nil];
    
    isEdit = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //-------here put rightBarButtonItem named Edit-nomal and Save-hightlight
 
    editBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, 15, 40, 40)];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [editBtn setTitleColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTintColor:[UIColor lightGrayColor]];
    editBtn.alpha = 1.0;
    editBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:editBtn];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 2)];
    lineImg.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:lineImg];
    
    if ([self.pushType isEqualToString:@"ChatPush"]) {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 27, 12, 20)];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTintColor:[UIColor lightGrayColor]];
        backBtn.alpha = 1.0;
        
        backBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [self.view addSubview:backBtn];
    }
    else{
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 22, 15)];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setTintColor:[UIColor lightGrayColor]];
        leftBtn.alpha = 1.0;
        leftBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [self.view addSubview:leftBtn];
    }
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Profile Jobseeker";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    profileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 72) style:UITableViewStylePlain];
    profileTable.dataSource = self;
    profileTable.delegate = self;
    [profileTable setBackgroundColor:[UIColor clearColor]];
    profileTable.userInteractionEnabled=YES;
    [profileTable setAllowsSelection:YES];
    if ([profileTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [profileTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [profileTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:profileTable];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return keywordsArray.count;
    }
    if (section == 4) {
        return workArray.count;
    }
    if (section == 5) {
        return educationArray.count;
    }
    if (section == 6) {
        return awardsArray.count;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return headerArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *CellIdentifier = @"HeaderCell";
    
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
    
    if (section == 1) {
        headerTxt = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 120, 20)];
        headerTxt.text = [headerArray objectAtIndex:section];
        headerTxt.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        headerTxt.returnKeyType = UIReturnKeyDone;
        headerTxt.delegate = self;
        headerTxt.enabled = NO;
        [cell.contentView addSubview:headerTxt];
        
        cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    }
    else{
        UILabel *headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 40, 20)];
        headerLbl.text = [headerArray objectAtIndex:section];
        headerLbl.font = [UIFont systemFontOfSize:15.0];
        headerLbl.textAlignment = NSTextAlignmentLeft;
        headerLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [cell.contentView addSubview:headerLbl];
        
        cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    headerTxt.enabled = NO;
    isEdit = NO;
    [headerTxt resignFirstResponder];
    [profileTable reloadData];
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
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
    
    if (indexPath.section == 0) {
        UIImageView *profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 75, 10, 150, 150)];
        //profileImg.image = [UIImage imageNamed:@"userImg.png"];
        profileImg.layer.cornerRadius = 75;
        profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
        profileImg.layer.borderWidth = 1;
        profileImg.layer.masksToBounds = YES;
        self.profileImg = profileImg;
        [cell.contentView addSubview:profileImg];
        
        UIButton *changeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, self.view.frame.size.width - 40, 40)];
        [changeImgBtn setTitle:@"Change profile picture" forState:UIControlStateNormal];
        changeImgBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [changeImgBtn setTitleColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [changeImgBtn addTarget:self action:@selector(changeImgBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [changeImgBtn setTintColor:[UIColor lightGrayColor]];
        changeImgBtn.alpha = 1.0;
        changeImgBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:changeImgBtn];
    }
    
    if (indexPath.section == 1) {
        UILabel *pitchLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 40, 100)];
        pitchLbl.text = @"This is my quote.";
        pitchLbl.font = [UIFont systemFontOfSize:15.0];
        pitchLbl.textAlignment = NSTextAlignmentLeft;
        pitchLbl.numberOfLines = 6;
        pitchLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [cell.contentView addSubview:pitchLbl];
    }
    
    if (indexPath.section == 2) {
        UIImageView *videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width - 40, 150)];
        videoImg.image = [UIImage imageNamed:@"postImg.png"];
        videoImg.backgroundColor = [UIColor blackColor];
        videoImg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:videoImg];
        
        UIButton *changeVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, self.view.frame.size.width - 40, 40)];
        [changeVideoBtn setTitle:@"Change video" forState:UIControlStateNormal];
        changeVideoBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [changeVideoBtn setTitleColor:[UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [changeVideoBtn addTarget:self action:@selector(changeVideoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [changeVideoBtn setTintColor:[UIColor lightGrayColor]];
        changeVideoBtn.alpha = 1.0;
        changeVideoBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:changeVideoBtn];
    }
    
    if (indexPath.section == 3) {
        UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width - 40, 20)];
        clientNameLbl.text = [keywordsArray objectAtIndex:indexPath.row];
        clientNameLbl.font = [UIFont systemFontOfSize:15.0];
        clientNameLbl.textAlignment = NSTextAlignmentLeft;
        clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [cell.contentView addSubview:clientNameLbl];
        
        UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 17, 10, 16)];
        [chatBtn setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [chatBtn setTintColor:[UIColor lightGrayColor]];
        chatBtn.alpha = 1.0;
        chatBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:chatBtn];
        
        UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [cell.contentView addSubview:lineImg3];
    }
    
    if (indexPath.section == 4) {
        UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width - 40, 20)];
        clientNameLbl.text = [workArray objectAtIndex:indexPath.row];
        clientNameLbl.font = [UIFont systemFontOfSize:15.0];
        clientNameLbl.textAlignment = NSTextAlignmentLeft;
        clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [cell.contentView addSubview:clientNameLbl];
        
        UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 17, 10, 16)];
        [chatBtn setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [chatBtn setTintColor:[UIColor lightGrayColor]];
        chatBtn.alpha = 1.0;
        chatBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:chatBtn];
        
        UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [cell.contentView addSubview:lineImg3];
    }
    
    if (indexPath.section == 5) {
        UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width - 40, 20)];
        clientNameLbl.text = [educationArray objectAtIndex:indexPath.row];
        clientNameLbl.font = [UIFont systemFontOfSize:15.0];
        clientNameLbl.textAlignment = NSTextAlignmentLeft;
        clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [cell.contentView addSubview:clientNameLbl];
        
        UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 17, 10, 16)];
        [chatBtn setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [chatBtn setTintColor:[UIColor lightGrayColor]];
        chatBtn.alpha = 1.0;
        chatBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:chatBtn];
        
        UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [cell.contentView addSubview:lineImg3];
    }
    
    if (indexPath.section == 6) {
        UILabel *clientNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, self.view.frame.size.width - 40, 20)];
        clientNameLbl.text = [awardsArray objectAtIndex:indexPath.row];
        clientNameLbl.font = [UIFont systemFontOfSize:15.0];
        clientNameLbl.textAlignment = NSTextAlignmentLeft;
        clientNameLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        [cell.contentView addSubview:clientNameLbl];
        
        UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 17, 10, 16)];
        [chatBtn setBackgroundImage:[UIImage imageNamed:@"goBtn.png"] forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [chatBtn setTintColor:[UIColor lightGrayColor]];
        chatBtn.alpha = 1.0;
        chatBtn.transform = CGAffineTransformMakeTranslation(10, 0);
        [cell.contentView addSubview:chatBtn];
        
        UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        lineImg3.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [cell.contentView addSubview:lineImg3];
    }
    
    return cell;
}

- (void)chatBtnclicked:(UIButton *)sender{
    
}

- (void)editBtnClicked{
    if (isEdit == YES) {
        [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        headerTxt.enabled = NO;
        isEdit = NO;
        [headerTxt resignFirstResponder];
        [profileTable reloadData];
    }
    else{
        [editBtn setTitle:@"Save" forState:UIControlStateNormal];
        headerTxt.enabled = YES;
        isEdit = YES;
        [headerTxt becomeFirstResponder];
    }
}

- (void)changeImgBtnClicked{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    self.profileImg.image = image;
    //need to save image to database
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)changeVideoBtnClicked{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }
    if (indexPath.section == 1) {
        return 120;
    }
    if (indexPath.section == 2) {
        return 200;
    }
    if (indexPath.section == 3) {
        return 50;
    }
    if (indexPath.section == 4) {
        return 50;
    }
    if (indexPath.section == 5) {
        return 50;
    }
    if (indexPath.section == 6) {
        return 50;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            JobKeyViewController *view = [[JobKeyViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
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
