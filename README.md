# ISPageScrollView

Note: This is a sub-project of [UIKitHelper](https://github.com/tonyzonghui/UIKitHelper) git project. You may want to use UIKitHelper in your project for more UIKit utilities.

---

### Description

ISPageScrollView is a UIScrollView subclass optimised for huge number of pages display. It uses lazy-loading mechanism to maintain only the previous few pages and the next few pages in order to minimize the memory usage.

### Properties:

**id\<ISPageScrollViewDataSource> dataSource**: Like UITableViewDataSource, it asks its dataSource object for views displayed in each page.

**NSInteger numberOfReusablePages**: number of pages maintanined in memory. This number should be an odd number (e.g: 5 = current displayed page + 2 pages in front + 2 pages after)

**NSInteger numberOfPages**: number of total pages

**NSMutableDictionary readonly scrollViewAvailablePages**: this is the dictionary that stores the views of the pages in memory. The keys for the dictionary are NSNumbers for page index. The values for each key is an UIView object.

### Usage

It can be created in xcode like UIScollView or can be created programatically.


```
ISPageScrollView *pageScrollView = [[ISPageScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
pageScrollView.dataSource = self;
pageScrollView.numberOfPages = 10;
pageScrollView.numberOfReusableViews = 5;

[pageScrollView displayPage:0];

```

# License
---
UIKitHelper is available under the MIT license. See the LICENSE file for more info.

