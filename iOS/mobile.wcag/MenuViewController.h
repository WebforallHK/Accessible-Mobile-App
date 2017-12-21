//
//  MenuViewController.h
//  mobile.wcag
//
//

#ifndef MenuViewController_h
#define MenuViewController_h

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end


#endif /* MenuViewController_h */
