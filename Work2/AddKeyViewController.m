//
//  AddKeyViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "AddKeyViewController.h"

@interface AddKeyViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    UITextField *keywordTxt;
    UITextView  *descTxtView;
}
@end

@implementation AddKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    titleLbl.text = @"Add keyword";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 15, 50, 40)];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [doneBtn setTitleColor:[UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTintColor:[UIColor lightGrayColor]];
    doneBtn.alpha = 1.0;
    doneBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:doneBtn];
    
    UILabel *keybl = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 20)];
    keybl.text = @"Keyword";
    keybl.font = [UIFont systemFontOfSize:15.0];
    keybl.textAlignment = NSTextAlignmentCenter;
    keybl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:keybl];
    
    UIImageView *keyBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 105, 200, 40)];
    keyBackImg.image = [UIImage imageNamed:@"searchBack.png"];
    [self.view addSubview:keyBackImg];
    
    keywordTxt = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 90, 110, 180, 30)];
    keywordTxt.delegate = self;
    keywordTxt.placeholder = @"keyword";
    keywordTxt.backgroundColor = [UIColor clearColor];
    keywordTxt.textColor = [UIColor grayColor];
    keywordTxt.font = [UIFont systemFontOfSize:16];
    [keywordTxt setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    keywordTxt.keyboardType = UIKeyboardTypeAlphabet;
    [self.view addSubview:keywordTxt];
    
    UILabel *declbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 20)];
    declbl.text = @"Description";
    declbl.font = [UIFont systemFontOfSize:15.0];
    declbl.textAlignment = NSTextAlignmentCenter;
    declbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
    [self.view addSubview:declbl];
    
    descTxtView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 185, 200, 120)];
    descTxtView.delegate = self;
    descTxtView.layer.borderColor = [UIColor colorWithRed:149.0/255.0 green:149.0/255.0 blue:149.0/255.0 alpha:1.0].CGColor;
    descTxtView.layer.borderWidth = 1;
    descTxtView.layer.cornerRadius = 5;
    descTxtView.layer.masksToBounds = YES;
    descTxtView.font = [UIFont systemFontOfSize:16];
    descTxtView.textColor = [UIColor grayColor];
    [self.view addSubview:descTxtView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewTap:(UIGestureRecognizer *)gesture{
    [keywordTxt resignFirstResponder];
    [descTxtView resignFirstResponder];
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
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
