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
    [encoder encodeObject:self.expertLanguage forKey:@"expertLanguage"];
    [encoder encodeObject:self.officeLocation forKey:@"officeLocation"];
    [encoder encodeObject:self.bio forKey:@"bio"];
    [encoder encodeObject:self.latitude forKey:@"lat"];
    [encoder encodeObject:self.longitude forKey:@"long"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageString = [decoder decodeObjectForKey:@"imageString"];
        self.expertLanguage = [decoder decodeObjectForKey:@"expertLanguage"];
        self.officeLocation = [decoder decodeObjectForKey:@"officeLocation"];
        self.bio = [decoder decodeObjectForKey:@"bio"];
        self.latitude = [decoder decodeObjectForKey:@"lat"];
        self.longitude = [decoder decodeObjectForKey:@"long"];
    }
    return self;
}

@end
