//
//  VideoViewController.h
//  mobile.wcag
//
//

#ifndef VideoViewController_h
#define VideoViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"
#import "CusTabBarController.h"

@interface VideoViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

#endif /* VideoViewController_h */
