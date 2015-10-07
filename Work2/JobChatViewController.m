//
//  JobChatViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobChatViewController.h"
#import "JobAccountViewController.h"

@interface JobChatViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView *chatTable;
    NSMutableArray *chatArray;
    
    UIView *sendView;
    UITextField *sendText;
    
    BOOL chatType;
}
@end

@implementation JobChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chatArray = [[NSMutableArray alloc] init];
    
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
    
    UIButton *profileBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 50, 70)];
    [profileBtn addTarget:self action:@selector(profileBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [profileBtn setTintColor:[UIColor lightGrayColor]];
    profileBtn.alpha = 1.0;
    profileBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:profileBtn];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Johanna Derck";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UIImageView *onlineImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 4, 55, 8, 8)];
    onlineImg.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    onlineImg.layer.cornerRadius = 4;
    onlineImg.layer.masksToBounds = YES;
    [self.view addSubview:onlineImg];
    
    UIImageView *profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 20, 40, 40)];
    profileImg.image = [UIImage imageNamed:@"userImg.png"];
    profileImg.layer.cornerRadius = 20;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImg.layer.borderWidth = 1;
    profileImg.layer.masksToBounds = YES;
    [self.view addSubview:profileImg];
    
    chatTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 112) style:UITableViewStylePlain];
    chatTable.dataSource = self;
    chatTable.delegate = self;
    [chatTable setBackgroundColor:[UIColor clearColor]];
    chatTable.userInteractionEnabled=YES;
    [chatTable setAllowsSelection:YES];
    if ([chatTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [chatTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [chatTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:chatTable];
    
    sendView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 41, self.view.frame.size.width, 40)];
    sendView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sendView.layer.borderWidth = 1;
    sendView.layer.cornerRadius = 3;
    sendView.layer.masksToBounds = YES;
    sendView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 200, 34)];
    lineImg1.backgroundColor = [UIColor clearColor];
    lineImg1.layer.cornerRadius = 5;
    lineImg1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lineImg1.layer.borderWidth = 1;
    lineImg1.layer.masksToBounds = YES;
    [sendView addSubview:lineImg1];
    
    sendText = [[UITextField alloc] initWithFrame:CGRectMake(25, 5, 190, 30)];
    sendText.backgroundColor = [UIColor whiteColor];
    sendText.textColor = [UIColor grayColor];
    sendText.font = [UIFont systemFontOfSize:15.0];
    sendText.placeholder = @"Message";
    sendText.keyboardType = UIKeyboardTypeDefault;
    sendText.delegate = self;
    [sendText setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [sendView addSubview:sendText];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(sendView.frame.size.width - 80, 5, 60, 30)];
    [sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTintColor:[UIColor lightGrayColor]];
    sendBtn.alpha = 1.0;
    sendBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [sendView addSubview:sendBtn];
    
    [self.view addSubview:sendView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - tableViewDelegate
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return chatArray.count;
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
    
    if (chatType == YES) {
        UILabel *chatLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width - 30, 50)];
        chatLbl.text = [chatArray objectAtIndex:indexPath.row];
        chatLbl.font = [UIFont systemFontOfSize:15.0];
        chatLbl.textAlignment = NSTextAlignmentRight;
        chatLbl.textColor = [UIColor blackColor];
        chatLbl.numberOfLines = 3;
        [cell.contentView addSubview:chatLbl];
    }
    else{
        UILabel *chatLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width - 30, 50)];
        chatLbl.text = [chatArray objectAtIndex:indexPath.row];
        chatLbl.font = [UIFont systemFontOfSize:15.0];
        chatLbl.textAlignment = NSTextAlignmentLeft;
        chatLbl.textColor = [UIColor blackColor];
        chatLbl.numberOfLines = 3;
        [cell.contentView addSubview:chatLbl];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Height of the rows
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewTapped:(UIGestureRecognizer *)gesture {
    [sendText resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        sendView.frame = CGRectMake(0, self.view.frame.size.height - 41, self.view.frame.size.width, 40);
    }completion:^(BOOL finished){
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        sendView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 40);
    }completion:^(BOOL finished){
        
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        sendView.frame = CGRectMake(0, self.view.frame.size.height - 41, self.view.frame.size.width, 40);
    }completion:^(BOOL finished){
        
    }];

    return YES;
}

- (void)sendBtnClicked{
    chatType = YES;
    [sendText resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        sendView.frame = CGRectMake(0, self.view.frame.size.height - 41, self.view.frame.size.width, 40);
    }completion:^(BOOL finished){
        
    }];
    
    [chatArray addObject:sendText.text];
    [chatTable reloadData];
    sendText.text = @"";
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)profileBtnClicked{
    JobAccountViewController *accountView = [[JobAccountViewController alloc] init];
    accountView.pushType = @"ChatPush";
    [self.navigationController pushViewController:accountView animated:YES];
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
