//
//  RegisterNowViewController.h
//  mobile.wcag
//
//

#ifndef RegisterNowViewController_h
#define RegisterNowViewController_h
#import "AppDelegate.h"
#import "Seminar.h"
#import "CusTabBarController.h"

@interface RegisterNowViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property(nonatomic, strong) IBOutlet UILabel *startDateLbl;
@property(nonatomic, strong) IBOutlet UILabel *endDateLbl;
@property(nonatomic, strong) IBOutlet UIButton *startDateBtn;
@property(nonatomic, strong) IBOutlet UIButton *endDateBtn;
@property(nonatomic, strong) IBOutlet UIButton *nextBtn;
@property(nonatomic, strong) Seminar *seminar;
@property(nonatomic, strong) NSMutableArray *futureEventArray;
@property(nonatomic, strong) NSDate *todayDate;
@property(nonatomic, strong) NSString *todayDateStr;
@property(nonatomic, strong) NSString *startDateStr;
@property(nonatomic, strong) NSString *endDateStr;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;


@property(nonatomic) BOOL isStartDateEmpty;
@property(nonatomic) BOOL isEndDateEmpty;
@property(nonatomic) BOOL isStartDateLaterThanEndDate;


-(IBAction)btnStartPressed:(id)sender;
-(IBAction)btnEndPressed:(id)sender;
-(IBAction)btnNextPressed:(id)sender;
-(IBAction)btnMenuPressed:(id)sender;
-(IBAction) btnBackPressed:(id)sender;


//-(void)sendStartDateToRegisterNowViewController:(NSString *)startDateStr;
//-(void)sendEndDateToRegisterNowViewController:(NSString *)endDateStr;

@end

#endif /* RegisterNowViewController_h */
