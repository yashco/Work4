//
//  JobMapViewController.m
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import "JobMapViewController.h"
#import "RESideMenu.h"

#import <CoreLocation/CoreLocation.h>

#import "JobChatViewController.h"

#import "JPSThumbnailAnnotation.h"
#import "SVAnnotation.h"
#import "SVPulsingAnnotationView.h"

#define METERS_PER_MILE 1609.344

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height

@interface JobMapViewController ()
{
    CGFloat latitude;
    CGFloat longitude;
}
@end

@implementation JobMapViewController
@synthesize PlaceInfo;

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
    titleLbl.text = @"Mapview";
    titleLbl.font = [UIFont systemFontOfSize:17.0];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
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
    
    myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 72, Width, Height - 72)];
    [self.view addSubview:myMapView];
    myMapView.showsUserLocation=YES;
    [myMapView setMapType:MKMapTypeStandard];
    [myMapView setZoomEnabled:YES];
    [myMapView setScrollEnabled:YES];
    
    myMapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    myMapView.delegate = self;
    [self.view addSubview:myMapView];
    
    // Annotations
    [myMapView addAnnotations:[self annotations]];
}

- (NSArray *)annotations {
    // Empire State Building
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"profileImg.jpg"];
    empire.title = @"PPP";
    empire.subtitle = @"PPP";
    empire.coordinate = CLLocationCoordinate2DMake(45.62442, -73.47450);
    empire.disclosureBlock = ^{ NSLog(@"selected Empire"); };
    
    // Apple HQ
    JPSThumbnail *apple = [[JPSThumbnail alloc] init];
    apple.image = [UIImage imageNamed:@"profileImg.jpg"];
    apple.title = @"AAA";
    apple.subtitle = @"AAA";
    apple.coordinate = CLLocationCoordinate2DMake(45.42433, -73.67455);
    apple.disclosureBlock = ^{ NSLog(@"selected Appple"); };
    
    // Parliament of Canada
    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    ottawa.image = [UIImage imageNamed:@"profileImg.jpg"];
    ottawa.title = @"BBB";
    ottawa.subtitle = @"BBB";
    ottawa.coordinate = CLLocationCoordinate2DMake(45.72436, -73.27440);
    ottawa.disclosureBlock = ^{ NSLog(@"selected Ottawa"); };
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire],
             [JPSThumbnailAnnotation annotationWithThumbnail:apple],
             [JPSThumbnailAnnotation annotationWithThumbnail:ottawa]];
}

- (void)viewDidAppear:(BOOL)animated {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(45.52439, -73.57447);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.4, 0.4));
    [myMapView setRegion:region animated:NO];
    SVAnnotation *annotation = [[SVAnnotation alloc] initWithCoordinate:coordinate];
    annotation.title = @"Current Location";
    annotation.subtitle = @"Current Location";
    [myMapView addAnnotation:annotation];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    
    if([annotation isKindOfClass:[SVAnnotation class]]) {
        static NSString *identifier = @"currentLocation";
        SVPulsingAnnotationView *pulsingView = (SVPulsingAnnotationView *)[myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
        if(pulsingView == nil) {
            pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pulsingView.annotationColor = [UIColor colorWithRed:86.0/255.0 green:191.0/255.0 blue:185.0/255.0 alpha:1.0];
            pulsingView.canShowCallout = YES;
        }
        return pulsingView;
    }
    return nil;
}

- (void)messageBtnClicked{
    JobChatViewController *chatView = [[JobChatViewController alloc] init];
    [self.navigationController pushViewController:chatView animated:YES];
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
