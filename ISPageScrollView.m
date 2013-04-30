//
//  ISPageScrollView.m
//  TestInfiniteScrollView
//
//  Created by Zhang Zonghui on 30/4/13.
//  Copyright (c) 2013 PhoneSoul. All rights reserved.
//

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
