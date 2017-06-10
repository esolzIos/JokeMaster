//
//  JMHeaderView.h
//  JokeMaster
//
//  Created by priyanka on 07/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIImageView *langImage;
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIView *moreView;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

@end
