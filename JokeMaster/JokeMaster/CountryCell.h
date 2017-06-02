//
//  CountryCell.h
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CountryImage;
@property (weak, nonatomic) IBOutlet UILabel *CountryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CheckImage;
@property (weak, nonatomic) IBOutlet UIButton *CheckButton;

@end
