//
//  TutorOfficeHoursViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TutorOfficeHoursViewController.h"
#import "CustomTableViewCell.h"
#import "Tutor.h"

@interface TutorOfficeHoursViewController ()

@property (nonatomic) NSMutableArray *usersComing;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *officeLocation;

@end

@implementation TutorOfficeHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [userDefaults objectForKey:@"tutee"];
    NSData *encodedDataTwo = [userDefaults objectForKey:@"tutor"];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    Tutor *tutor = [NSKeyedUnarchiver unarchiveObjectWithData:encodedDataTwo];
    
    if (user != nil){
    self.imageView.image = [UIImage imageNamed:tutor.imageString];
    self.nameLabel.text = tutor.name;
    self.officeLocation.text = tutor.officeLocation;
    } else {
        nil;
    }
    
    NSLog(@"Users: %@",user);
    
    self.usersComing = [[NSMutableArray alloc]init];
    
    if (user != nil){
    [self.usersComing addObject:user];
    } else {
        nil;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.usersComing.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:
//                             indexPath];
    //cell.textLabel.text = @"Jamaal";
    
//CustomCellIdentifier
    

static NSString *id = @"CustomCellIdentifier";
        
    CustomTableViewCell*cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:id];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    User *thisUser = self.usersComing[indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ is coming to office hours!",thisUser.name];
    cell.customImageView.image = [UIImage imageNamed:thisUser.imageString];
    cell.languageLabel.text = [NSString stringWithFormat:@"Learning:%@",thisUser.languageLearning];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}
@end
