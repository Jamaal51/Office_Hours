//
//  TutorCustomAnnotation.h
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Tutor.h"
#import "User.h"

@interface TutorCustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic) User *userPass;
@property (nonatomic) Tutor *tutorPass;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

-(id)initWithTitle:(NSString*)newTitle Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;

@end
