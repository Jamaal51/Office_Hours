//
//  TutorDetailViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TutorDetailViewController.h"

@interface TutorDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation TutorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"User Passed: %@",self.thisUser);
    
    self.imageView.layer.cornerRadius = 50;
    self.imageView.image = [UIImage imageNamed:self.thisTutor.imageString];
    self.nameLabel.text = self.thisTutor.name;
    self.locationLabel.text = [NSString stringWithFormat:@"You can find me at %@.",self.thisTutor.officeLocation];
    self.bioLabel.text = self.thisTutor.bio;
    
    Tutor *tutor = self.thisTutor;
    
    NSLog(@"Tutor Passed: %@",tutor);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bookButtonTapped:(UIButton *)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self.thisUser];
    [userDefaults setObject:encodedData forKey:@"tutee"];
    [userDefaults synchronize];
    
}
- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
