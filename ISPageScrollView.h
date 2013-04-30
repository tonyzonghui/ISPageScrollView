//
//  ISPageScrollView.h
//  TestInfiniteScrollView
//
//  Created by Zhang Zonghui on 30/4/13.
//  Copyright (c) 2013 PhoneSoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISPageScrollViewDataSource <NSObject>

- (UIView *)viewForScrollView:(UIScrollView *)scrollView Page:(NSInteger)pageIndex;

@end

@interface ISPageScrollView : UIScrollView

@property (nonatomic, assign) id<ISPageScrollViewDataSource> dataSource;
@property (nonatomic, assign) NSInteger numberOfReusableViews;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, readonly) NSMutableDictionary *scrollViewAvailablePages;

- (void)displayPage:(NSInteger)pageIndex;

@end
