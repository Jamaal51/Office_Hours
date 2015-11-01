//
//  User.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.imageString  forKey:@"imageString"];
    [encoder encodeObject:self.languageLearning forKey:@"languageLearning"];
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
        self.languageLearning = [decoder decodeObjectForKey:@"languageLearning"];
        self.officeLocation = [decoder decodeObjectForKey:@"officeLocation"];
        self.bio = [decoder decodeObjectForKey:@"bio"];
        self.latitude = [decoder decodeObjectForKey:@"lat"];
        self.longitude = [decoder decodeObjectForKey:@"long"];
    }
    return self;
}


@end
