//
//  LoginViewController.m
//  Office_Hours
//
//  Created by Artur Lan on 10/31/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults boolForKey:@"registered"]) {
        self.login.hidden = YES;
    }
    else {
        self.confirmPassword.hidden = YES;
        self.registerUser.hidden = YES;
    }
    
}
- (IBAction)registerUser:(UIButton *)sender {
    if ([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""] || [self.confirmPassword.text isEqualToString:@""]) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Dude" message:@"You have to complete all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [error show];
    }
    else {
        [self checkPasswordMatch];
    }
}

- (void)checkPasswordMatch {
    if ([self.password.text isEqualToString:self.confirmPassword.text]) {
        NSLog(@"Passwords match");
        [self registerNewUser];
    }
    else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Dude" message:@"Your password don't match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    
}

- (void)registerNewUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.username.text forKey:@"username"];
    [defaults setObject:self.password.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    [defaults synchronize];
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Dude" message:@"You have to complete all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    [self performSegueWithIdentifier:@"login" sender:self];
}
- (IBAction)login:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([self.username.text isEqualToString:@"username"] && [self.password.text isEqualToString:@"password"]) {
        NSLog(@"login credentials accepted");
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Dude" message:@"Wrong password or username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [error show];
    }
    
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
