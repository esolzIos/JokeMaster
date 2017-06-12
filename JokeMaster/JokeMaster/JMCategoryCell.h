//
//  JMCategoryCell.h
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CategoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CheckImage;
@property (weak, nonatomic) IBOutlet UIButton *CheckButton;
@end
