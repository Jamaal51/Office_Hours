//
//  SearchOfficeHoursViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "SearchOfficeHoursViewController.h"
#import "Tutor.h"

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
    
    
    if (self.allTutors == nil){
        self.allTutors = [[NSMutableArray alloc]init];
    }
    
    [self createModelTutors];
    
    //NSLog(@"All Tutors: %@",self.allTutors);
}

- (void) createModelTutors {
    
    Tutor *henna = [[Tutor alloc]init];
    henna.name = @"Henna";
    henna.imageString = @"hennaahmed";
    henna.borough = @"Queens";
    henna.officeName = @"New York City's YMCA";
    henna.officeHours = @"Thursdays, 2 to 4";
    henna.officeLocation = @"93-11 101st Ave, Ozone Park, NY";
    henna.bio = @"Hi! I'm Henna. I'm great with Objective-C and Javascript! I'd love to help you out!";
    henna.expertLanguage = @"Objective-C";
    [self.allTutors addObject:henna];
    
    Tutor *jamaal = [[Tutor alloc] init];
    jamaal.name = @"Jamaal";
    jamaal.imageString = @"jamaalsedayao";
    jamaal.borough = @"Brooklyn";
    jamaal.officeName = @"Sit & Wonder";
    jamaal.officeHours = @"Wednesdays 6 to 8";
    jamaal.officeLocation = @"688 Washington Ave, Brooklyn, NY";
    jamaal.bio = @"Hey all! Super pumped to help you with Objective-C and Swift!";
    jamaal.expertLanguage = @"Swift";
    [self.allTutors addObject:jamaal];
    
    
    Tutor *charles = [[Tutor alloc] init];
    charles.name = @"Charles";
    charles.imageString = @"charleskang";
    charles.borough = @"Manhattan";
    charles.officeName = @"The Chipped Cup";
    charles.officeHours = @"Saturdays 12 - 2";
    charles.officeLocation = @"3610 Broadway, New York, NY 10031";
    charles.bio = @"Charles here ready to answer any Objective-C or Ruby questions for you";
    charles.expertLanguage = @"Objective-C";
    [self.allTutors addObject:charles];
    
    Tutor *artur = [[Tutor alloc]init];
    artur.name = @"Artur";
    artur.imageString = @"arturlan";
    artur.borough = @"Queens";
    artur.officeName = @"Red Pipe Cafe";
    artur.officeLocation = @"71-60 Austin St, Forest Hills, NY 11375";
    artur.bio = @"Hi, I'm Artur. I can help you with Objective-C and C++";
    artur.expertLanguage = @"Javascript";
    [self.allTutors addObject:artur];
    
    NSArray *tutorsArray = self.allTutors;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataArray = [NSKeyedArchiver archivedDataWithRootObject:tutorsArray];
    [userDefaults setObject:encodedDataArray forKey:@"tutorsArray"];
    [userDefaults synchronize];
    
}

- (IBAction)searchOfficeHours:(UIButton *)sender {


NSInteger rowOne = [self.languagePickerView selectedRowInComponent:0];
NSString *language = [self.languages objectAtIndex:rowOne];

NSInteger rowTwo = [self.boroPickerView selectedRowInComponent:0];
NSString *boro = [self.boros objectAtIndex:rowTwo];
    
    
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
NSData *encodedObject = [userDefaults objectForKey:@"tutorsArray"];
NSArray *tutorsArray = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedObject];
    
//NSLog(@"Tutors Array:%@",tutorsArray);

self.searchResults = [[NSMutableArray alloc]init];

NSLog(@"Language picked: %@", language);
NSLog(@"Boro picked: %@", boro);

for (Tutor *tutors in tutorsArray){
    if ([tutors.borough isEqual:boro] && [tutors.expertLanguage isEqual:language]) {
        [self.searchResults addObject:tutors];
    }
}
NSLog(@"Tutors: %@",self.searchResults);


[self.tableView reloadData];

}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender: DetailViewController *viewController = segue.destinationViewController;
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 Tutor *tutorPass = self.searchResults[indexPath.row];
 NSLog(@"Tutor to Pass:%@",tutorPass);
 viewController.tutorDetail = tutorPass;
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
    
    Tutor *thisTutor = self.searchResults[indexPath.row];
    
    cell.textLabel.text = thisTutor.name;
    cell.imageView.image = [UIImage imageNamed:thisTutor.imageString];
    
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
