//
//  JMHeaderView.m
//  JokeMaster
//
//  Created by priyanka on 07/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMHeaderView.h"
#import <UIKit/UIKit.h>
@implementation JMHeaderView

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
        
        // header label font according to screen size
        [self.HeaderLabel setFont:[UIFont fontWithName:self.HeaderLabel.font.fontName size:[self getFontSize:self.HeaderLabel.font.pointSize]]];
        
        // header label shadow
        self.HeaderLabel.layer.shadowColor = [[UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.3] CGColor];
        self.HeaderLabel.layer.shadowOffset = CGSizeMake(-2.0f,3.0f);
        self.HeaderLabel.layer.shadowOpacity = 1.0f;
        self.HeaderLabel.layer.shadowRadius = 1.0f;
        
        
        
        return self;
    }
    return nil;
    
    
    
    
}
-(CGFloat)getFontSize:(CGFloat)size
{
    
    if (IsIphone5) {
        
        size+=1.0;
    }
    else
        if (IsIphone6) {
            
            size+=4.0;
        }
        else  if (IsIphone6plus) {
            
            size+=6.0;
        }
    
        else if (IsIpad)
        {
            size+=6.0;
        }
    return size;
}

@end
