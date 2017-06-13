//
//  JMLeftMenuView.h
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMLeftMenuCell.h"
#import "JMGlobalHeader.h"
#import "LocalizationSystem.h"
@protocol Side_menu_delegate<NSObject>
@optional
-(void)action_method:(NSInteger )sender;
@end
@interface JMLeftMenuView : UIView<UITableViewDataSource,UITableViewDelegate>
+ (id)leftmenu;
@property (strong, nonatomic) IBOutlet UIView *view;
@property(assign)id<Side_menu_delegate>SideDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UITableView *LeftMenuTable;
-(CGFloat)getFontSize:(CGFloat)size;
@end
