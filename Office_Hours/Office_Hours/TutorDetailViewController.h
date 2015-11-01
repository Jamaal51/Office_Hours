//
//  TutorDetailViewController.h
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutor.h"
#import "User.h"
#import <Parse/Parse.h>


@interface TutorDetailViewController : UIViewController

@property (nonatomic) Tutor *thisTutor;
@property (nonatomic) User *thisUser;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIButton *post;

@end
