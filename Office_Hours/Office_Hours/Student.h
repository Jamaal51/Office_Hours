//
//  Student.h
//  Office_Hours
//
//  Created by Charles Kang on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface Student : PFObject <PFSubclassing>

@property (nonatomic) NSString *studentName;
@property (nonatomic) NSString *studentLanguage;

@end
