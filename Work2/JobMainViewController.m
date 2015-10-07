//
//  JobMainViewController.m
//  Work2
//
//  Created by topone on 9/7/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobMainViewController.h"
#import "RESideMenu.h"
#import "DraggableViewBackground.h"
#import "GetJobs.h"

#import "JobChatViewController.h"

@interface JobMainViewController ()


@property(nonatomic,strong)NSMutableArray *jobsArray;

@end

@implementation JobMainViewController

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
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, 28, 16, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rightBtn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTintColor:[UIColor lightGrayColor]];
    rightBtn.alpha = 1.0;
    rightBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:rightBtn];
    
    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 28, 22, 22)];
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"messageBtn.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setTintColor:[UIColor lightGrayColor]];
    messageBtn.alpha = 1.0;
    messageBtn.transform = CGAffineTransformMakeTranslation(10, 0);
    [self.view addSubview:messageBtn];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 25)];
    titleLbl.text = @"Main Screen";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UILabel *searchLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, 20)];
    searchLbl.text = @"Your search";
    searchLbl.font = [UIFont systemFontOfSize:15.0];
    searchLbl.textAlignment = NSTextAlignmentCenter;
    searchLbl.textColor = [UIColor grayColor];
    [self.view addSubview:searchLbl];

    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 72)];
    [self.view addSubview:draggableBackground];
    
    //[self   sendRequest];hitesh
    
}
-(NSArray *)sendRequest{
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://yashco.info/odbaseapi/index.php/job/?method=getAllJobs&page=1"]];
    
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    
    
    NSOperationQueue *queue= [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
        NSError *error2 = nil;
        NSDictionary *dictionary2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error2];
        
        
        NSLog(@"error2=%@",error2);
        NSLog(@"Data2=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

        NSLog(@"response=%@",response.observationInfo);
        NSLog(@"dictionary2=%@",dictionary2);
        NSLog(@"connectionError=%@",connectionError);
        
    }];
    /*
     */
    
    
    NSLog(@"error=%@",error);
    NSError *parseError = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
    NSArray *jsondata = [dictionary objectForKey:@"jobs"];
    
    NSLog(@"dictionary=%@",dictionary);
      NSLog(@"jsonData=%@",jsondata);
    NSLog(@"parseError=%@",parseError);
     NSLog(@"Data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
     NSLog(@"jsondata=%@",jsondata);
    
    for (NSDictionary *jobDic in jsondata) {
        
        GetJobs *job = [GetJobs parseJobsInfoData:jobDic];
        
        [self.jobsArray addObject:job];
 
    }

    return jsondata;

}
- (void)checkBtnClicked{
    
}

- (void)messageBtnClicked{
    JobChatViewController *chatView = [[JobChatViewController alloc] init];
    [self.navigationController pushViewController:chatView animated:YES];
}

- (void)downListBtnClicked{
    
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
