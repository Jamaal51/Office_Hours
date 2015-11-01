//
//  SearchOfficeHoursViewController.h
//  Office_Hours
//
//  Created by Jamaal Sedayao on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface SearchOfficeHoursViewController : UIViewController
<
UIPickerViewDataSource,
UIPickerViewDelegate,
MKMapViewDelegate,
CLLocationManagerDelegate   
>

@property (nonatomic) User *myUser;

@end
