//
//  JobMapViewController.h
//  Work2
//
//  Created by topone on 9/16/15.
//  Copyright (c) 2015 omar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface JobMapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView *myMapView;
}

@property (nonatomic, strong) NSMutableArray *PlaceInfo;

@end
