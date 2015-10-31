//
//  Tutor.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "Tutor.h"

@implementation Tutor

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageString  forKey:@"imageString"];
    [encoder encodeObject:self.borough forKey:@"borough"];
    [encoder encodeObject:self.expertLanguage forKey:@"expertLanguage"];
    [encoder encodeObject:self.officeName  forKey:@"officeName"];
    [encoder encodeObject:self.officeHours forKey:@"officeHours"];
    [encoder encodeObject:self.officeLocation forKey:@"officeLocation"];
    [encoder encodeObject:self.bio forKey:@"bio"];
}

//@property (nonatomic) NSString *name;
//@property (nonatomic) NSString *imageString;
//@property (nonatomic) NSString *borough;
//@property (nonatomic) NSString *expertLanguage;
//@property (nonatomic) NSString *officeName;
//@property (nonatomic) NSString *officeHours;
//@property (nonatomic) NSString *officeLocation;
//@property (nonatomic) NSString *bio;

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageString = [decoder decodeObjectForKey:@"imageString"];
        self.borough = [decoder decodeObjectForKey:@"borough"];
        self.expertLanguage = [decoder decodeObjectForKey:@"expertLanguage"];
        self.officeName = [decoder decodeObjectForKey:@"officeName"];
        self.officeHours = [decoder decodeObjectForKey:@"officeHours"];
        self.officeLocation = [decoder decodeObjectForKey:@"officeLocation"];
        self.bio = [decoder decodeObjectForKey:@"bio"];
        
    }
    return self;
}

@end
