//
//  SeminarViewController.h
//  mobile.wcag
//
//

#define SeminarViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

#define TIMER_COUNT_SEM 1
#define SECTION_HEIGHT 60

@interface SeminarViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *autoUpdateBtn;
@property (nonatomic, strong) IBOutlet UIButton *findEventBtn;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *seminarArray;
@property (nonatomic, strong) NSMutableArray *pastEventArray;
@property (nonatomic, strong) NSMutableArray *futureEventArray;
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableDictionary *mdict;

-(void)rollingImage;
-(IBAction)btnAutoUpdatePressed:(id)sender;
-(IBAction)btnFindEventPressed:(id)sender;

@end
