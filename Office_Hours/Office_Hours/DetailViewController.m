//
//  DetailViewController.m
//  Office_Hours
//
//  Created by Artur Lan on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *like;
@property (weak, nonatomic) IBOutlet UIButton *red;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *array;
@end

@implementation DetailViewController
- (IBAction)likeButton:(UIButton *)sender {
    [self.like setHidden:YES];
    [self.red setHidden:NO];
}
- (IBAction)likeRedButton:(UIButton *)sender {
    [self.like setHidden:NO];
    [self.red setHidden:YES];
}
- (IBAction)commentButton:(UIButton *)sender {
    [self.tableView setHidden:NO];
    [self.commentButton setHidden:NO];
    [self.text setHidden:NO];
}
- (IBAction)post:(UIButton *)sender {
    NSString *enteredText = self.text.text;
    PFObject *textObject = [PFObject objectWithClassName:@"Comment"];
    [textObject setObject:enteredText forKey:@"theText"];
    [textObject save];
    self.text.text = @"";
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self queryForTable];
    [self.red setHidden:YES];
    
//    [self.tableView setHidden:YES];
//    [self.commentButton setHidden:YES];
//    [self.text setHidden:YES];
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
