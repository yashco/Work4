//
//  DraggableView.m
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


#import "DraggableView.h"
#import "SignUpViewController.h"
#import "UIImageView+WebCache.h"

@interface DraggableView ()

@property(nonatomic,strong)SignUpViewController *jobSignUpVC;

@end

@implementation DraggableView
{
    CGFloat xFromCenter;
    CGFloat yFromCenter;
    UIScrollView *scrollView;
}

//delegate is instance of ViewController
@synthesize delegate;

@synthesize panGestureRecognizer;
@synthesize profileImg, titleLbl, descriptionLbl, partLbl;
@synthesize empolyLbl, scheduleLbl, termLbl, extraLbl, hourLbl, locationLbl, salaryLbl;
@synthesize overlayView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        //Custom
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.alwaysBounceVertical = YES;
        scrollView.contentSize = CGSizeMake(self.frame.size.width, 1000);
        
        profileImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 80, 80)];
       profileImg.image = [UIImage imageNamed:@"heijImg.png"];
        
        
        
        profileImg.image = self.jobSignUpVC.fbProfileImage.image;
        profileImg.layer.cornerRadius = 40;
        profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
        profileImg.layer.borderWidth = 1;
        profileImg.layer.masksToBounds = YES;
        [scrollView addSubview:profileImg];
        
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, self.frame.size.width - 90, 30)];
        titleLbl.text = @"Heijmans";
        titleLbl.font = [UIFont boldSystemFontOfSize:22.0];
        titleLbl.textAlignment = NSTextAlignmentLeft;
        titleLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:titleLbl];
        
        partLbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, self.frame.size.width - 90, 30)];
        partLbl.text = @"Executive Manager";
        partLbl.font = [UIFont systemFontOfSize:20.0];
        partLbl.textAlignment = NSTextAlignmentLeft;
        partLbl.textColor = [UIColor blackColor];
        [scrollView addSubview:partLbl];
        
        descriptionLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.frame.size.width - 20, 60)];
        descriptionLbl.text = @"asdfasdgasdgasdgasdgasdgasdgasdgasdgsdgasdgdsdfgsdfgsdfgsdg";
        descriptionLbl.numberOfLines = 4;
        descriptionLbl.font = [UIFont systemFontOfSize:13.0];
        descriptionLbl.textAlignment = NSTextAlignmentLeft;
        descriptionLbl.textColor = [UIColor blackColor];
        [scrollView addSubview:descriptionLbl];
        
        empolyLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, descriptionLbl.frame.origin.y + descriptionLbl.frame.size.height + 15, 100, 20)];
        empolyLbl.text = @"Empolyment:";
        empolyLbl.font = [UIFont systemFontOfSize:16.0];
        empolyLbl.textAlignment = NSTextAlignmentLeft;
        empolyLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:empolyLbl];
        
        salaryLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, descriptionLbl.frame.origin.y + descriptionLbl.frame.size.height + 15, 100, 20)];
        salaryLbl.text = @"Salary:";
        salaryLbl.font = [UIFont systemFontOfSize:16.0];
        salaryLbl.textAlignment = NSTextAlignmentLeft;
        salaryLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:salaryLbl];
        
        scheduleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, empolyLbl.frame.origin.y + empolyLbl.frame.size.height + 10, 100, 20)];
        scheduleLbl.text = @"Schedule:";
        scheduleLbl.font = [UIFont systemFontOfSize:16.0];
        scheduleLbl.textAlignment = NSTextAlignmentLeft;
        scheduleLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:scheduleLbl];
        
        hourLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, scheduleLbl.frame.origin.y + scheduleLbl.frame.size.height + 10, 100, 20)];
        hourLbl.text = @"Hours:";
        hourLbl.font = [UIFont systemFontOfSize:16.0];
        hourLbl.textAlignment = NSTextAlignmentLeft;
        hourLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:hourLbl];
        
        locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, scheduleLbl.frame.origin.y + scheduleLbl.frame.size.height + 10, 100, 20)];
        locationLbl.text = @"Location:";
        locationLbl.font = [UIFont systemFontOfSize:16.0];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        locationLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:locationLbl];
        
        termLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, hourLbl.frame.origin.y + hourLbl.frame.size.height + 10, 100, 20)];
        termLbl.text = @"Term:";
        termLbl.font = [UIFont systemFontOfSize:16.0];
        termLbl.textAlignment = NSTextAlignmentLeft;
        termLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:termLbl];
        
        extraLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, hourLbl.frame.origin.y + hourLbl.frame.size.height + 10, 100, 20)];
        extraLbl.text = @"Extra:";
        extraLbl.font = [UIFont systemFontOfSize:16.0];
        extraLbl.textAlignment = NSTextAlignmentLeft;
        extraLbl.textColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
        [scrollView addSubview:extraLbl];
        
        UILabel *video = [[UILabel alloc] initWithFrame:CGRectMake(5, termLbl.frame.origin.y + termLbl.frame.size.height + 20, 100, 30)];
        video.text = @"Video";
        video.font = [UIFont systemFontOfSize:18.0];
        video.textAlignment = NSTextAlignmentLeft;
        video.textColor = [UIColor grayColor];
        [scrollView addSubview:video];
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, video.frame.origin.y + video.frame.size.height, self.frame.size.width - 4, 1)];
        lineImg.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineImg];
        
        UIImageView *postImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, video.frame.origin.y + video.frame.size.height + 20, self.frame.size.width - 10, (self.frame.size.width - 10)/5*3)];
        postImg.backgroundColor = [UIColor whiteColor];
        postImg.image = [UIImage imageNamed:@"postImg.png"];
        [scrollView addSubview:postImg];
        
        UILabel *function = [[UILabel alloc] initWithFrame:CGRectMake(5, postImg.frame.origin.y + postImg.frame.size.height + 10, 100, 30)];
        function.text = @"Function";
        function.font = [UIFont systemFontOfSize:18.0];
        function.textAlignment = NSTextAlignmentLeft;
        function.textColor = [UIColor grayColor];
        [scrollView addSubview:function];
        
        UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, function.frame.origin.y + function.frame.size.height, self.frame.size.width - 4, 1)];
        lineImg1.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineImg1];
        
        UILabel *functionLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, function.frame.origin.y + function.frame.size.height + 10, self.frame.size.width - 20, 120)];
        functionLbl.text = @"asdfasdgasdgasdgasdgasdgasdgasdgasdgsdgasdgdsdfgsdfgsdfgsdgasdfgasdgasgasgadsfgdfgasdasfdgasfgasdfgsdfgsdfgsdfghsdfhsdfgasdfgasdfgasdfgasfgasfgasfgasfg";
        functionLbl.numberOfLines = 10;
        functionLbl.font = [UIFont systemFontOfSize:13.0];
        functionLbl.textAlignment = NSTextAlignmentLeft;
        functionLbl.textColor = [UIColor blackColor];
        [scrollView addSubview:functionLbl];
        
        [self addSubview:scrollView];
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
    }
    return self;
}

-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

// called many times a second
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    //%%% this extracts the coordinate data from your swipe movement. (i.e. How much did you move?)
    xFromCenter = [gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down
    
    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];
            
            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.mode = GGOverlayViewModeRight;
    } else {
        overlayView.mode = GGOverlayViewModeLeft;
    }
    
    overlayView.alpha = MIN(fabsf(distance)/100, 0.4);
}

//%%% called when the card is let go
- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}

-(void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

-(void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}



@end
