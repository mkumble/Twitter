//
//  TweetsViewController.m
//  Twitter
//
//  Created by Mithun Kumble on 9/22/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeTweetViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray*  tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic)   UILabel *labelRight;
@end

@implementation TweetsViewController

- (void)viewDidLoad {


    [super viewDidLoad];
    
    self.labelRight = [[UILabel alloc] initWithFrame:CGRectMake(200, -5, 100, 100)];
    self.labelRight.font = [UIFont boldSystemFontOfSize:16];
    self.labelRight.adjustsFontSizeToFitWidth = NO;
    self.labelRight.textAlignment = UITextAlignmentRight;
    self.labelRight.textColor = [UIColor whiteColor];
    self.labelRight.text = @"New";
    
    
    [self.navigationController.view addSubview:self.labelRight];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.labelRight setUserInteractionEnabled:YES];
    [self.labelRight addGestureRecognizer:singleFingerTap];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
       self.refreshControl = [[UIRefreshControl  alloc]init];
    [self.refreshControl  addTarget: self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex: 0];
    
    [self fetchData];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TweetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tw = self.tweets[indexPath.row];
    User *user = tw.user;
    
     [cell.profileImageUrl setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];

    cell.tweetMessage.text = tw.text;
     cell.tweetMessage.lineBreakMode=NSLineBreakByWordWrapping;
    
    cell.userName.text = user.screenName;
    
    return cell;
}

-(void) fetchData {
    
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"tweets: %@", responseObject);
        self.tweets = [Tweet tweetsWithArray:responseObject];
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error getting tweets");
    }];
    
               [self.refreshControl endRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeTweetViewController *composeTweetViewController = (ComposeTweetViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ComposeTweetViewController"];
        self.labelRight.text = @"Home";
     [self.navigationController pushViewController:composeTweetViewController animated:YES];
}

@end
