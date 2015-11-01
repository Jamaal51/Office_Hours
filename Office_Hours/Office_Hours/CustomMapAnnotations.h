//
//  CustomMapAnnotations.h
//  Office_Hours
//
//  Created by Charles Kang on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Tutor.h"

@interface CustomMapAnnotations : MKAnnotationView

@property (nonatomic) Tutor *tutorAnnotation;

@end
