//
//  HomePageViewController.m
//
//
//  Created by Jamaal Sedayao on 10/31/15.
//
//

#import "HomePageViewController.h"
#import "User.h"
#import "SearchOfficeHoursViewController.h"

@interface HomePageViewController ()

@property (nonatomic) User *myUser;
@property (weak, nonatomic) IBOutlet UIButton *mentorUI;
@property (weak, nonatomic) IBOutlet UIButton *studentUI;


@end

@implementation HomePageViewController


- (IBAction)mentorBoxField:(id)sender {
    
    [[self.mentorUI layer] setBorderWidth:2.0f];
    [[self.mentorUI layer] setBorderColor:[UIColor whiteColor].CGColor];
}

- (IBAction)studentBoxField:(id)sender {
    
    [[self.studentUI layer] setBorderWidth:2.0f];
    [[self.studentUI layer] setBorderColor:[UIColor whiteColor].CGColor];
    [self.view endEditing:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedData = [userDefaults objectForKey:@"user"];
    
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    NSLog(@"User: %@",user);
    
    self.myUser = user;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"PassToSearchViewController"]){
        SearchOfficeHoursViewController *viewController = segue.destinationViewController;
        viewController.myUser = self.myUser;
        
    }
    
    
    
}


@end
