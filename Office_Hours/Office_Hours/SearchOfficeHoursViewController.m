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
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableArray *allTutors;
@property (nonatomic) NSMutableArray *searchResults;
@property (nonatomic) NSArray *languages;

@end

@implementation SearchOfficeHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //All the delegates
    self.languagePickerView.delegate = self;
    self.languagePickerView.dataSource = self;
    self.mapView.delegate = self;
    self.locationManager.delegate = self;
    
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
    
    
    if (self.allTutors == nil){
        self.allTutors = [[NSMutableArray alloc]init];
    }
    
    self.mapView.showsUserLocation = YES;
    
    [self setCurrentLocation];
    [self createModelTutors];
    
    //NSLog(@"All Tutors: %@",self.allTutors);
}
- (void) setCurrentLocation{
    //40.742436, -73.935376
    
    if (self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc]init];
    }
    self.locationManager.delegate = self;
    
    //mandatory check http://stackoverflow.com/questions/24062509/location-services-not-working-in-ios-8
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self.locationManager requestAlwaysAuthorization];
    }
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    NSString *ourLocationString = [NSString stringWithFormat:@"ll=%f,%f",self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    
    NSLog(@"our current location: %@",ourLocationString);

    
    //double latitude = 40.742436;
    //double longitude = -73.935376;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000.0, 2000.0);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Student";
    point.subtitle = @"Looking for some coding help!";
    
    [self.mapView addAnnotation:point];
}

- (void) createModelTutors {
    
    Tutor *henna = [[Tutor alloc]init];
    henna.name = @"Henna";
    henna.imageString = @"hennaahmed";
    henna.officeLocation = @"93-11 101st Ave, Ozone Park, NY";
    henna.bio = @"Hi! I'm Henna. I'm great with Objective-C and Javascript! I'd love to help you out!";
    henna.expertLanguage = @"Objective-C";
    [self.allTutors addObject:henna];
    
    Tutor *jamaal = [[Tutor alloc] init];
    jamaal.name = @"Jamaal";
    jamaal.imageString = @"jamaalsedayao";
    jamaal.officeLocation = @"688 Washington Ave, Brooklyn, NY";
    jamaal.bio = @"Hey all! Super pumped to help you with Objective-C and Swift!";
    jamaal.expertLanguage = @"Swift";
    [self.allTutors addObject:jamaal];
    
    
    Tutor *charles = [[Tutor alloc] init];
    charles.name = @"Charles";
    charles.imageString = @"charleskang";
    charles.officeLocation = @"3610 Broadway, New York, NY 10031";
    charles.bio = @"Charles here ready to answer any Objective-C or Ruby questions for you";
    charles.expertLanguage = @"Objective-C";
    [self.allTutors addObject:charles];
    
    Tutor *artur = [[Tutor alloc]init];
    artur.name = @"Artur";
    artur.imageString = @"arturlan";
    artur.officeLocation = @"71-60 Austin St, Forest Hills, NY 11375";
    artur.bio = @"Hi, I'm Artur. I can help you with Objective-C and C++";
    artur.expertLanguage = @"Javascript";
    [self.allTutors addObject:artur];
    
    Tutor *derek = [[Tutor alloc]init];
    derek.name = @"Derek";
    derek.imageString = @"dereknetto";
    derek.officeLocation = @"61-51 188th St, Fresh Meadows, NY 11365";
    derek.expertLanguage = @"Ruby";
    derek.bio = @"Hey I'm Derek and I want to help you with Ruby! I also know Objective-C and Swift!";
    [self.allTutors addObject:derek];
    
    Tutor *mesfin = [[Tutor alloc]init];
    mesfin.name = @"Mesfin";
    mesfin.imageString = @"mesfinmekonnen";
    mesfin.officeLocation = @"1603 Cortelyou Rd, Brooklyn, NY 11226";
    mesfin.expertLanguage = @"C++";
    mesfin.bio = @"Hey I'm Mesfin and I want to help you with C++! I also know Objective-C and Swift!";
    [self.allTutors addObject:mesfin];
    
    NSArray *tutorsArray = self.allTutors;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataArray = [NSKeyedArchiver archivedDataWithRootObject:tutorsArray];
    [userDefaults setObject:encodedDataArray forKey:@"tutorsArray"];
    [userDefaults synchronize];
    
}

- (IBAction)searchOfficeHours:(UIButton *)sender {


NSInteger rowOne = [self.languagePickerView selectedRowInComponent:0];
NSString *language = [self.languages objectAtIndex:rowOne];
    
    
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
NSData *encodedObject = [userDefaults objectForKey:@"tutorsArray"];
NSArray *tutorsArray = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedObject];
    
//NSLog(@"Tutors Array:%@",tutorsArray);

self.searchResults = [[NSMutableArray alloc]init];

NSLog(@"Language picked: %@", language);

for (Tutor *tutors in tutorsArray){
    if ([tutors.expertLanguage isEqual:language]) {
        [self.searchResults addObject:tutors];
    }
}
NSLog(@"Tutors: %@",self.searchResults);


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

#pragma mark - Picker View Data Source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        return self.languages.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        return self.languages[row];

}


@end
