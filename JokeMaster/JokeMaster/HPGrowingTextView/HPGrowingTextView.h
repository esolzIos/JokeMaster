//
//  HPGrowingTextView.h
//
//  Created by Hans Pinckaers on 29-06-10.
//
//	MIT License
//
//	Copyright (c) 2011 Hans Pinckaers
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import <UIKit/UIKit.h>

@class HPGrowingTextView;

@protocol HPGrowingTextViewDelegate <NSObject>

@optional
- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldEndEditing:(HPGrowingTextView *)growingTextView;

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView;
- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView;

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView;

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height;
- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height;

- (void)growingTextViewDidChangeSelection:(HPGrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView;
@end

@interface HPGrowingTextView : UIView <UITextViewDelegate> 

//real class properties
@property (nonatomic) int maxNumberOfLines;
@property (nonatomic) int minNumberOfLines;
@property (nonatomic) BOOL animateHeightChange;
@property (unsafe_unretained, nonatomic) id<HPGrowingTextViewDelegate> delegate;

// UITextView properties
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (nonatomic) UITextAlignment textAlignment;    // default is UITextAlignmentLeft
@property (nonatomic) NSRange selectedRange;            // only ranges of length 0 are supported
@property (nonatomic,getter=isEditable) BOOL editable;
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) UIEdgeInsets scrollIndicatorInsets;
@property (nonatomic) BOOL enablesReturnKeyAutomatically;

//uitextview methods
//need others? use .internalTextView
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;

- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;

@end