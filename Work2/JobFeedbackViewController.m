//
//  JobFeedbackViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobFeedbackViewController.h"
#import "RESideMenu.h"


@interface JobFeedbackViewController ()<UITextFieldDelegate, UITextViewDelegate, RESideMenuDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

{
    UITextField *toEmailTxt;
    UITextField *copyTxt;
    UITextField *subjectTxt;
    UITextView  *contentTView;
}
@end

@implementation JobFeedbackViewController


-(void)viewDidLoad{
    
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
    titleLbl.text = @"Feedback";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 45, 30, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"sendMailBtn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sendMailBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTintColor:[UIColor lightGrayColor]];
    rightBtn.alpha = 1.0;
    rightBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:rightBtn];

    [self line:nil];
}

- (void)sendMailBtnClicked{
    [self line:nil];
}

#pragma MFMailComposeViewControllerDelegate
-(void)line:(id)sender{
    //email title
    NSString *emailTitle = [NSString stringWithFormat:@"%@",@""];
    
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"%@",@""];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
