//
//  JMFavouriteCell.h
//  JokeMaster
//
//  Created by priyanka on 14/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@interface JMFavouriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIView *WhiteView;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *ProfileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *JokesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *RatingLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *RatingView;
@property (weak, nonatomic) IBOutlet UILabel *RankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CrownImage;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profileFrame;

@end
