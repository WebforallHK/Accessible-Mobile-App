//
//  SettingViewController.h
//  mobile.wcag
//
//

#ifndef SettingViewController_h
#define SettingViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *optionArray;
@property (nonatomic, strong) NSMutableDictionary *mdict;

//-(void)initMethod;

@end

#endif /* SettingViewController_h */
