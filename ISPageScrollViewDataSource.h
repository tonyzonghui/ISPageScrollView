//
//  ISPageScrollViewDataSource.h
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

@protocol ISPageScrollViewDataSource <NSObject>

@required
/**
 * The view for given scroll view and page. This method is required.
 */
- (UIView *)viewForScrollView:(ISPageScrollView *)scrollView
						 page:(NSInteger)pageIndex;

/**
 * The number of pages in given scroll view. This method is required.
 * 
 * The number of pages must be larger than the number of reusable views.
 */
- (NSInteger)numberOfPagesForPageScrollView:(ISPageScrollView *)scrollView;

@end