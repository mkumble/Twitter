//
//  TweetCell.h
//  Twitter
//
//  Created by Mithun Kumble on 9/22/16.
//  Copyright © 2016 myapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetMessage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageUrl;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
