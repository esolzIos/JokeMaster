//
//  ReviewsTableViewCell.h
//  JokeMaster
//
//  Created by santanu on 14/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface ReviewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *reviewDate;
//@property (strong, nonatomic) IBOutlet UIView *ratingView;
@property (strong, nonatomic) IBOutlet UIImageView *rating1;
@property (strong, nonatomic) IBOutlet UIImageView *rating2;
@property (strong, nonatomic) IBOutlet UIImageView *rating3;
@property (strong, nonatomic) IBOutlet UIImageView *rating4;
@property (strong, nonatomic) IBOutlet UIImageView *rating5;
@property (strong, nonatomic) IBOutlet UILabel *ratingLbl;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UITextView *reviewTxt;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@end
