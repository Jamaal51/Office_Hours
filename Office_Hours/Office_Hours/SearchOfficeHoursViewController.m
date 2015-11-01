//
//  SearchOfficeHoursViewController.m
//  Office_Hours
//
//  Created by Jamaal Sedayao on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "SearchOfficeHoursViewController.h"
#import "Tutor.h"
#import "TutorDetailViewController.h"
#import "TutorCustomAnnotation.h"


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
    
    NSLog(@"My User: %@",self.myUser);
    
    //Set Default location to zoom
    CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(40.742436, -73.935376); //Create the CLLocation from user cordinates
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000); //Set zooming level
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion]; //add location to map
    [self.mapView setRegion:adjustedRegion animated:YES]; // create animation zooming
    
    // Place Annotation Point
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
    [annotation1 setCoordinate:CLLocationCoordinate2DMake(40.742436, -73.935376)]; //Add cordinates
    [self.mapView addAnnotation:annotation1];
    
    
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
    self.mapView.zoomEnabled = YES;
    
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
    
    // custom map view annotations
    
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
//1
    Tutor *henna = [[Tutor alloc]init];
    henna.name = @"Henna";
    henna.imageString = @"hennaahmed";
    henna.officeLocation = @"Astoria Coffee: 3004 30th St. Astoria, NY 11102";
    henna.bio = @"Hi! I'm Henna. I'm great with Objective-C and Javascript! I'd love to help you out!";
    henna.expertLanguage = @"Objective-C";
    henna.latitude = @"40.767418";
    henna.longitude = @"-73.922408";
    [self.allTutors addObject:henna];
//2
    Tutor *jamaal = [[Tutor alloc] init];
    jamaal.name = @"Jamaal";
    jamaal.imageString = @"jamaalsedayao";
    jamaal.officeLocation = @"Upright Coffee: 860 Manhattan Ave Brooklyn, NY 11222";
    jamaal.bio = @"Hey all! Super pumped to help you with Objective-C and Swift!";
    jamaal.expertLanguage = @"Swift";
    jamaal.latitude = @"40.729511";
    jamaal.longitude = @"-73.953594";
    [self.allTutors addObject:jamaal];
//3
    Tutor *charles = [[Tutor alloc] init];
    charles.name = @"Charles";
    charles.imageString = @"charleskang";
    charles.officeLocation = @"Propeller Coffee: 984 Manhattan Ave, Brooklyn, NY 11222";
    charles.bio = @"Charles here ready to answer any Objective-C or Ruby questions for you";
    charles.expertLanguage = @"Objective-C";
    charles.latitude = @"40.732990";
    charles.longitude = @"-73.954438";
    [self.allTutors addObject:charles];
//4
    Tutor *artur = [[Tutor alloc]init];
    artur.name = @"Artur";
    artur.imageString = @"arturlan";
    artur.officeLocation = @"Cafe Grumpy: 193 Meserole Ave, Brooklyn, NY 11222";
    artur.bio = @"Hi, I'm Artur. I can help you with Objective-C and C++";
    artur.expertLanguage = @"Objective-C";
    artur.latitude = @"40.728846";
    artur.longitude = @"-73.948739";
    [self.allTutors addObject:artur];
//5
    Tutor *derek = [[Tutor alloc]init];
    derek.name = @"Derek";
    derek.imageString = @"dereknetto";
    derek.officeLocation = @"Ashbox: 1154 Manhattan Ave, Brooklyn, NY 11222";
    derek.expertLanguage = @"Swift";
    derek.bio = @"Hey I'm Derek and I want to help you with Swift! I also know Javascript and Swift!";
    derek.latitude = @"40.738004";
    derek.longitude = @"-73.955203";
    [self.allTutors addObject:derek];
//6
    Tutor *mesfin = [[Tutor alloc]init];
    mesfin.name = @"Mesfin";
    mesfin.imageString = @"mesfinmekonnen";
    mesfin.officeLocation = @"The Queens Kickshaw: 40-17 BROADWAY, ASTORIA, NY, USA";
    mesfin.expertLanguage = @"Objective-C";
    mesfin.bio = @"Hey I'm Mesfin and I want to help you with Objective-C! I also know C# and Swift!";
    mesfin.latitude = @"40.759076";
    mesfin.longitude = @"-73.918225";
    [self.allTutors addObject:mesfin];
//7
    Tutor *justine = [[Tutor alloc]init];
    justine.name = @"Justine";
    justine.imageString = @"justinekay";
    justine.officeLocation = @"SweetLeaf LIC: 10-93 Jackson Ave, Long Island City, NY 11101";
    justine.expertLanguage = @"Objective-C";
    justine.bio = @"Hey I'm Justine and I'm great with Objective-C! I also know Ruby and Swift!";
    justine.latitude = @"40.743565";
    justine.longitude = @" -73.951682";
    [self.allTutors addObject:justine];
 //8
    Tutor *kaira = [[Tutor alloc]init];
    kaira.name = @"Kaira";
    kaira.imageString = @"kaira";
    kaira.officeLocation = @"Sweet Leaf Williamsburg : 135 Kent Ave, New York, NY 11211";
    kaira.expertLanguage = @"Swift";
    kaira.bio = @"Hey I'm Kaira and I'm a Swift-master! I'm open to helping!";
    kaira.latitude = @"40.719815";
    kaira.longitude = @"-73.962200";
    [self.allTutors addObject:kaira];
//9
    Tutor *shena = [[Tutor alloc]init];
    shena.name = @"Shena";
    shena.imageString = @"shenayoshida";
    shena.officeLocation = @" Budin : 114 Greenpoint Ave, Brooklyn, NY 11222";
    shena.expertLanguage = @"Objective-C";
    shena.bio = @"Hi I'm Shena and I'm great at Objective-C! Ask me about it!";
    shena.latitude = @"40.730045";
    shena.longitude = @"-73.956161";
    [self.allTutors addObject:shena];
//10
    Tutor *varindra = [[Tutor alloc]init];
    varindra.name = @"Varinda";
    varindra.imageString = @"varindrahart";
    varindra.officeLocation = @"Kinship Coffee Coop.: 30-05 Steinway St, Astoria, NY 11103 ";
    varindra.expertLanguage = @"Swift";
    varindra.bio = @"Hi I'm V and I can help you with Swift and most C languages.";
    varindra.latitude = @"40.763893";
    varindra.longitude = @"-73.915093";
    
    NSArray *tutorsArray = self.allTutors;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedDataArray = [NSKeyedArchiver archivedDataWithRootObject:tutorsArray];
    [userDefaults setObject:encodedDataArray forKey:@"tutorsArray"];
    [userDefaults synchronize];
    
}

- (IBAction)searchOfficeHours:(UIButton *)sender {
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
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
            double latitude = [tutors.latitude doubleValue];
            double longitude = [tutors.longitude doubleValue];
            
            CLLocationCoordinate2D thisLocation = CLLocationCoordinate2DMake(latitude, longitude);
//            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//            point.coordinate = thisLocation;
//            point.title = tutors.name;
//            point.subtitle = tutors.bio;
//            [self.mapView addAnnotation:point];
            
            TutorCustomAnnotation *customAnnotation = [[TutorCustomAnnotation alloc]initWithTitle:[NSString stringWithFormat:@"%@ can help you!",tutors.name] Location:thisLocation];
            customAnnotation.tutorPass = tutors;
            customAnnotation.userPass = self.myUser;
            [self.mapView addAnnotation:customAnnotation];
        }
    }
    
    NSLog(@"Tutors: %@",self.searchResults);
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] init];
//    pin.tintColor = [UIColor redColor];
//    pin.canShowCallout = YES;
//    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    return pin;
    
    if ([annotation isKindOfClass:[TutorCustomAnnotation class]]){
        TutorCustomAnnotation *myLocation = (TutorCustomAnnotation*)annotation;
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnimation"];
        if (annotationView == nil){
            annotationView = myLocation.annotationView;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    } else {
    return nil;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
//    [self performSegueWithIdentifier:@"showBarDetails" sender:view];
   
    //Tutor *passTutor = [mapView.selectedAnnotations objectAtIndex:0];
    
    TutorCustomAnnotation *thisAnnotation = [mapView.selectedAnnotations objectAtIndex:0];
    
    TutorDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorDetailVC"];
    
    //Tutor *thisTutor = (Tutor*)view.annotation;
    
    viewController.thisTutor = thisAnnotation.tutorPass;
    viewController.thisUser = thisAnnotation.userPass;
    
    [self.navigationController presentViewController:viewController animated:YES completion:nil];

    
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


 
 }
 

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
