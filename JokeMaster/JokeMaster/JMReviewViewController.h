//
//  JMReviewViewController.h
//  JokeMaster
//
//  Created by santanu on 22/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMReviewViewController : JMGlobalMethods
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UIView *rateView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIView *fourView;
@property (strong, nonatomic) IBOutlet UIView *fiveView;
@property (strong, nonatomic) IBOutlet UIView *reviewView;
@property (strong, nonatomic) IBOutlet UILabel *commentTitle;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (strong, nonatomic) IBOutlet UITextView *commentTxt;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *one;
@property (strong, nonatomic) IBOutlet UIView *two;
@property (strong, nonatomic) IBOutlet UIView *three;
@property (strong, nonatomic) IBOutlet UIView *four;
@property (strong, nonatomic) IBOutlet UIView *five;
@property (strong, nonatomic) IBOutlet UILabel *rateTitle;

@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;

- (IBAction)oneClicked:(id)sender;
- (IBAction)twoClicked:(id)sender;
- (IBAction)threeClicked:(id)sender;
- (IBAction)fourClicked:(id)sender;
- (IBAction)fiveClicked:(id)sender;


@end
