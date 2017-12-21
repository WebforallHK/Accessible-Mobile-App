//
//  AboutChildViewController.h
//  mobile.wcag
//
//

#ifndef AboutChildViewController_h
#define AboutChildViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface AboutChildViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

#endif /* AboutChildViewController_h */
