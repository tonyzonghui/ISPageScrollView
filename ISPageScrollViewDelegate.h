//
//  ISPageScrollViewDelegate.h
//
//  Copyright (c) 2013 Zhang Zonghui
//  Created by Jos Kuijpers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

@class ISPageScrollView;

@protocol ISPageScrollViewDelegate <NSObject>

@optional
/**
 * Fired before given view at given pageIndex is removed
 */
- (void)pageScrollView:(ISPageScrollView *)scrollView
		willRemoveView:(UIView *)view
				atPage:(NSInteger)pageIndex;

/**
 * Fired after the view at given pageIndex is removed
 */
- (void)pageScrollView:(ISPageScrollView *)scrollView
   didRemoveViewAtPage:(NSInteger)pageIndex;

/**
 * Fired when the page scroll view started showing another page
 */
- (void)pageScrollView:(ISPageScrollView *)scrollView
		   didShowPage:(NSInteger)pageIndex;

@end
