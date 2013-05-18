//
//  ISPageScrollView.m
//  TestInfiniteScrollView
//
//  Copyright (c) 2013 Zhang Zonghui
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

#import "ISPageScrollView.h"

@interface ISPageScrollView () <UIScrollViewDelegate>

- (void)setupScrollViewForDisplayingPage:(NSInteger)pageIndex;

@end

@implementation ISPageScrollView {
    NSInteger _minReusablePageIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        [self setPagingEnabled:YES];
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        
        _scrollViewAvailablePages = [@{} mutableCopy];
        _numberOfPages = 0;
        _numberOfReusableViews = 0;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    [self setPagingEnabled:YES];
    [self setBounces:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    
    _scrollViewAvailablePages = [@{} mutableCopy];
    _numberOfPages = 0;
    _numberOfReusableViews = 0;    
}

#pragma mark - Accessor methods

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    if ( numberOfPages < self.numberOfReusableViews )
    {
        self.numberOfReusableViews = numberOfPages;
    }
    _numberOfPages = numberOfPages;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width + _minReusablePageIndex;
    
    [self setupScrollViewForDisplayingPage:currentPage];
}


#pragma mark - Private methods

- (void)displayPage:(NSInteger)pageIndex
{
    [self setupScrollViewForDisplayingPage:pageIndex];
}

- (void)setupScrollViewForDisplayingPage:(NSInteger)pageIndex
{
    NSInteger minPageIndex = MAX(0, pageIndex - (_numberOfReusableViews - 1) / 2.0);
    NSInteger maxPageIndex = MIN(_numberOfPages, pageIndex + (_numberOfReusableViews - 1) / 2.0);
    
    // remove unused views
    for ( NSNumber *pageIndex in _scrollViewAvailablePages.allKeys )
    {
        if ( pageIndex.integerValue < minPageIndex || pageIndex.integerValue > maxPageIndex )
        {
            [_scrollViewAvailablePages[pageIndex] removeFromSuperview];
            [_scrollViewAvailablePages removeObjectForKey:pageIndex];
        }
    }
    
    // add in new views
    for ( NSInteger i = minPageIndex; i <= maxPageIndex; i++ )
    {
        UIView *viewForPage = _scrollViewAvailablePages[@(i)];
        if ( viewForPage == nil )
        {
            viewForPage = [self.dataSource viewForScrollView:self Page:i];
            [self addSubview:viewForPage];
            [_scrollViewAvailablePages setObject:viewForPage forKey:@(i)];
        }
        
        viewForPage.frame = CGRectMake((i - minPageIndex) * self.frame.size.width, 0, viewForPage.frame.size.width, viewForPage.frame.size.height);
    }
    
    self.contentOffset = CGPointMake(self.frame.size.width * (pageIndex - minPageIndex), 0);
    self.contentSize = CGSizeMake(self.frame.size.width * (maxPageIndex - minPageIndex + 1), self.frame.size.height);
    _minReusablePageIndex = minPageIndex;
}


@end
