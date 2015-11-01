//
//  UserProfileViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *namelabel;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [[User alloc]init];
   
    self.user.name = @"Charles Kang";
    self.user.imageString = @"charleskang";
    self.user.languageLearning = @"Objective-C";
    self.user.bio = @"I'm a budding iOS developer, learning objective-c and trying to build my own website. I love to learn and I am NEVER late to class";
    self.user.latitude = @"40.742436";
    self.user.longitude = @"-73.935376";
    
    self.imageView.image = [UIImage imageNamed:self.user.imageString];
    self.namelabel.text = self.user.name;
    self.bioLabel.text = self.user.bio;
    self.languageLabel.text = [NSString stringWithFormat:@"Learning: %@",self.user.languageLearning];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataArray = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [userDefaults setObject:encodedDataArray forKey:@"user"];
    [userDefaults synchronize];
    
}


@end
