//
//  TutorDetailViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TutorDetailViewController.h"

@interface TutorDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *array;
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
    
    self.tableView.dataSource = self;
    [self queryForTable];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bookButtonTapped:(UIButton *)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self.thisUser];
    NSData *encodedDateTwo = [NSKeyedArchiver archivedDataWithRootObject:self.thisTutor];
    [userDefaults setObject:encodedData forKey:@"tutee"];
    [userDefaults setObject:encodedDateTwo forKey:@"tutor"];
    [userDefaults synchronize];
    
}
- (IBAction)post:(UIButton *)sender {
    NSString *enteredText = self.text.text;
    PFObject *textObject = [PFObject objectWithClassName:@"Comment"];
    [textObject setObject:enteredText forKey:@"theText"];
    [textObject save];
    self.text.text = @"";
    
}
- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.array = objects;
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.array[indexPath.row] valueForKey:@"theText"];
    //    cell.textLabel.text = [self.array o]
    
    return cell;
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
