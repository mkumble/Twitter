//
//  HamburgerViewController.m
//  Twitter
//
//  Created by Mithun Kumble on 9/22/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"
#import "TweetsViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) TweetsViewController *tweetsViewController;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic, assign) BOOL isMenuOpen;
@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isMenuOpen = NO;
    
    UIStoryboard *  storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    self.menuViewController.hamburgerViewController = self;
    
    [self.menuView addSubview:self.menuViewController.view];
    
        self.tweetsViewController = [storyboard instantiateViewControllerWithIdentifier:@"TweetsViewController"];
    [self setContentViewController:self.tweetsViewController];
    
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

- (void) setContentViewController:(UIViewController *)contentViewController{
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
    [self closeMenu];
}

- (void) openMenu {
    [UIView animateWithDuration:1.5 animations:^{ self.leftMarginConstraint.constant = 60;}];
    [self.view layoutIfNeeded];
    
   
}

- (void) closeMenu {
            self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
}

- (IBAction)onMenu:(id)sender {
    
    if(self.isMenuOpen) {
        [self closeMenu];
   
    }
    else {
        [self openMenu];
    }
    self.isMenuOpen ^= YES;
}
- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
        CGPoint translation = [sender translationInView:self.view];
        CGPoint velocity = [sender velocityInView:self.view];
    self.leftMarginConstraint.constant  = location.x;
    
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        
        
    }

else if(sender.state == UIGestureRecognizerStateChanged)
{
    
}
else if(sender.state == UIGestureRecognizerStateEnded)
{
    if(velocity.x < 0)
    {
        [self closeMenu];
    }
    else
    {
        [self openMenu];
    }
}



}


@end
