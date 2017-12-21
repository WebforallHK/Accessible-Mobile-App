//
//  RegisterSuccessViewController2.h
//  mobile.wcag
//
//

#ifndef RegisterSuccessBySearchViewController_h
#define RegisterSuccessBySearchViewController_h
#import <UIKit/UIKit.h>
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface RegisterSuccessBySearchViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property (nonatomic, strong) IBOutlet UITextView *descTxv;
@property(nonatomic, strong) IBOutlet UILabel *startDateLbl;
@property(nonatomic, strong) IBOutlet UILabel *endDateLbl;

@property(nonatomic, strong) IBOutlet UITextView *startDateTextView;
@property(nonatomic, strong) IBOutlet UITextView *endDateTextView;

@property(nonatomic, strong) IBOutlet UIButton *homeBtn;

@property(nonatomic,strong) Seminar *seminar;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnHomePressed:(id)sender;

@end


#endif /* RegisterSuccessViewController2_h */
