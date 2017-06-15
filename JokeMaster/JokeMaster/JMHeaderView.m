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
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat fontSize = 18.0;
        CGPoint point = CGPointMake(0, 0);
        
        UIFont *font = [UIFont fontWithName:@"GROBOLD" size:fontSize];
        UIColor *outline = [UIColor redColor];
        UIColor *fill = [UIColor blackColor];
        
        NSDictionary *labelAttr = @{NSForegroundColorAttributeName:outline, NSFontAttributeName:font};
        
        CGContextSetTextDrawingMode(context, kCGTextStroke);
        CGContextSetLineWidth(context, 2.0);
        [self.HeaderLabel.text drawAtPoint:point withAttributes:labelAttr];
        
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextSetLineWidth(context, 2.0);
        labelAttr = @{NSForegroundColorAttributeName:fill, NSFontAttributeName:font};
        [self.HeaderLabel.text drawAtPoint:point withAttributes:labelAttr];
        
        //  [FooterTabBar setTintColor:[UIColor whiteColor]];
        return self;
    }
    return nil;
    
    
    
    
}
@end
