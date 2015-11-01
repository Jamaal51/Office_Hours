//
//  TutorCustomAnnotation.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TutorCustomAnnotation.h"

@implementation TutorCustomAnnotation

-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location{
    
    self = [super init];
    
    if (self){
        _title = newTitle;
        _coordinate = location;
    }
    
    
    return self;
}

-(MKAnnotationView*)annotationView{
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"MyCustomAnimation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"pin1"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //annotationView.frame = CGRectMake(0, 0, 100, 100);
    
    return annotationView;
}

@end
