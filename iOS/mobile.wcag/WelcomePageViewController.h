//
//  WelcomePageViewController.h
//  mobile.wcag
//
//

#import <UIKit/UIKit.h>
#import "WelcomeContentViewController.h"
#import "AppDelegate.h"

#ifndef WelcomePageViewController_h
#define WelcomePageViewController_h


@interface WelcomePageViewController : UIViewController<UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSArray *arrPageTitles;
@property (nonatomic,strong) NSArray *arrPageImages;

- (WelcomeContentViewController *)viewControllerAtIndex:(NSUInteger)index;

- (IBAction)btnMenuPressed:(id)sender;
- (IBAction) btnBackPressed:(id)sender;

@end

#endif /* WelcomePageViewController_h */
