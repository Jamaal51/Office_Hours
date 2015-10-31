//
//  SearchOfficeHoursViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "SearchOfficeHoursViewController.h"

@interface SearchOfficeHoursViewController ()
@property (strong, nonatomic) IBOutlet UIPickerView *languagePickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *boroPickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *allTutors;
@property (nonatomic) NSMutableArray *searchResults;
@property (nonatomic) NSArray *languages;
@property (nonatomic) NSArray *boros;


@end

@implementation SearchOfficeHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //All the delegates
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.languagePickerView.delegate = self;
    self.languagePickerView.dataSource = self;
    self.boroPickerView.dataSource = self;
    self.boroPickerView.delegate = self;
    
    self.languages = @[
                       @"Objective-C",
                       @"Swift",
                       @"Java",
                       @"Javascript",
                       @"HTML/CSS",
                       @"Ruby",
                       @"C++",
                       @"C#",
                       @"Python"
                       ];
    self.boros = @[
                   @"Brooklyn",
                   @"Bronx",
                   @"Manhattan",
                   @"Queens",
                   @"Staten Island"
                   ];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - Picker View Data Source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([pickerView isEqual:self.languagePickerView]){
        return 1;
    } else if ([pickerView isEqual:self.boroPickerView]){
        return 1;
    } else {
        return 0;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if ([pickerView isEqual:self.languagePickerView]){
        return self.languages.count;;
    } else if ([pickerView isEqual:self.boroPickerView]){
        return self.boros.count;
    } else {
        return 0;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if ([pickerView isEqual:self.languagePickerView]){
        return self.languages[row];
    } else if ([pickerView isEqual:self.boroPickerView]){
        return self.boros[row];
    } else {
        return 0;
    }
}


@end
