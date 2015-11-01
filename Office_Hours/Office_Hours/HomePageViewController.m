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

@end

@implementation HomePageViewController

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
