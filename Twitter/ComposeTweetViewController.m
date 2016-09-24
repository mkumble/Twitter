//
//  ComposeTweetViewController.m
//  Twitter
//
//  Created by Mithun Kumble on 9/23/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface ComposeTweetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic)   UILabel *labelRight;
@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.labelRight = [[UILabel alloc] initWithFrame:CGRectMake(200, -5, 100, 100)];
    self.labelRight.font = [UIFont boldSystemFontOfSize:16];
    self.labelRight.adjustsFontSizeToFitWidth = NO;
    self.labelRight.textAlignment = UITextAlignmentRight;
    self.labelRight.textColor = [UIColor whiteColor];
    self.labelRight.text = @"Home";
    
    
    [self.navigationController.view addSubview:self.labelRight];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.labelRight setUserInteractionEnabled:YES];
    [self.labelRight addGestureRecognizer:singleFingerTap];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    




    [self.profileImage setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"profileImageUrl"]]];
    
    self.userName.text = [defaults objectForKey:@"screenName"];
    
    // Do any additional setup after loading the view.
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

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeTweetViewController *composeTweetViewController = (ComposeTweetViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TweetsViewController"];
    self.labelRight.text = @"New";
    [self.navigationController pushViewController:composeTweetViewController animated:YES];
}

@end
