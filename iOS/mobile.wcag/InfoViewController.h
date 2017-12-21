//
//  InfoViewController.h
//  mobile.wcag
//
//

#ifndef InfoViewController_h
#define InfoViewController_h

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end
#endif /* InfoViewController_h */
