//
//  JMLeftMenuView.h
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Side_menu_delegate<NSObject>
@optional
-(void)action_method:(NSInteger )sender;
@end
@interface JMLeftMenuView : UIView
+ (id)leftmenu;
@property (strong, nonatomic) IBOutlet UIView *view;
@property(assign)id<Side_menu_delegate>SideDelegate;
@end
