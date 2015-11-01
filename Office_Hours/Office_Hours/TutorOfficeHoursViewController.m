//
//  TutorOfficeHoursViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 11/1/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TutorOfficeHoursViewController.h"

@interface TutorOfficeHoursViewController ()

@property (nonatomic) NSMutableArray *usersComing;

@end

@implementation TutorOfficeHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [userDefaults objectForKey:@"tutee"];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:
                             indexPath];
    //cell.textLabel.text = @"Jamaal";
    User *thisUser = self.usersComing[indexPath.row];
    
    cell.textLabel.text = thisUser.name;
    cell.imageView.image = [UIImage imageNamed:thisUser.imageString];
    cell.detailTextLabel.text = thisUser.languageLearning;
    
    
    return cell;
}
@end
