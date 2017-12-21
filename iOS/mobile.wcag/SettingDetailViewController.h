//
//  SettingDetailViewController.h
//  mobile.wcag
//
//

#ifndef SettingDetailViewController_h
#define SettingDetailViewController_h
#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface SettingDetailViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableDictionary *passDict;
@property (nonatomic, strong) NSMutableArray *optionArray, *buttons;
@property (nonatomic, strong) NSMutableDictionary *mdict;

- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)btnSwitchPressed:(id)sender;
-(void) onRadioButtonValueChanged:(RadioButton*)sender;
- (IBAction)btnConfirmPressed:(id)sender;
- (IBAction) btnBackPressed:(id)sender;
@end

#endif /* SettingDetailViewController_h */
