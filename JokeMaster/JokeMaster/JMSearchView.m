//
//  JMSearchView.m
//  JokeMaster
//
//  Created by santanu on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMSearchView.h"
#import <UIKit/UIKit.h>
@implementation JMSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.view];
        

        
    
        
        
        
        return self;
    }
    return nil;
    
    
    
    
}


@end
