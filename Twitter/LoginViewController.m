//
//  LoginViewController.m
//  Twitter
//
//  Created by Mithun Kumble on 9/20/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
            NSLog(@"Welcome to %@", user.name);
        }
        else
        {
            //Present error view to user
        }
    }];
}

@end