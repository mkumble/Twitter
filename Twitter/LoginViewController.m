//
//  LoginViewController.m
//  Twitter
//
//  Created by Mithun Kumble on 9/20/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "HamburgerViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.42569828033447266 green:0.74675935506820679 blue:0.90954983234405518 alpha:1.0];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWIthCompletion:^(User *user, NSError * error) {
        if(user!= nil) {
            //Modally present tweets view
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:user.screenName forKey:@"screenName"];
            [defaults setObject:user.profileImageUrl forKey:@"profileImageUrl"];
            
            [defaults synchronize];
            
            
            
            NSLog(@"Welcome to %@", user.name);
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HamburgerViewController *hamburgerViewController = (HamburgerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HamburgerViewController"];
            [self.navigationController pushViewController:hamburgerViewController animated:YES];
        }
        else
        {
            //Present error view to user
        }
    }];
}

@end
