//
//  RegisterInfoViewController.h
//  mobile.wcag
//
//

#ifndef RegisterInfoViewController_h
#define RegisterInfoViewController_h
#import <UIKit/UIKit.h>
#import "Person.h"
#import "AppDelegate.h"
#import "Seminar.h"
#import "CusTabBarController.h"

#define MAX_COUNT 300

@interface RegisterInfoViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property(nonatomic, strong) IBOutlet UILabel *lastNameLbl;
@property(nonatomic, strong) IBOutlet UILabel *firstNameLbl;
@property(nonatomic, strong) IBOutlet UILabel *addressLbl;
@property(nonatomic, strong) IBOutlet UILabel *districtLbl;
@property(nonatomic, strong) IBOutlet UILabel *phoneLbl;
@property(nonatomic, strong) IBOutlet UILabel *timerLbl;
@property(nonatomic, strong) IBOutlet UITextField *firstNameTextField;
@property(nonatomic, strong) IBOutlet UITextField *lastNameTextField;
@property(nonatomic, strong) IBOutlet UITextField *addressTextField;

@property(nonatomic, strong) IBOutlet UITextField *phoneTextField;
@property(nonatomic, strong) IBOutlet UIButton *registerBtn;
@property(nonatomic, strong) IBOutlet UIButton *districtBtn;

@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) UIAlertController *alert;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) int counter;
@property(nonatomic, strong) Person *person;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *district;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic) int districtOption;
@property(nonatomic, strong) NSArray *districtArray;
@property(nonatomic) BOOL isFirstNameEmpty;
@property(nonatomic) BOOL isLastNameEmpty;
@property(nonatomic) BOOL isDistrictEmpty;
@property(nonatomic) BOOL isPhoneEmpty;
@property(nonatomic) BOOL is8DigitPhone;
@property(nonatomic) BOOL isNumericPhone;
@property(nonatomic) BOOL isBookingByDate;
@property(nonatomic, strong) Seminar *seminar;
@property (nonatomic) BOOL canBack;

- (IBAction)btnMenuPressed:(id)sender;
- (IBAction) btnBackPressed:(id)sender;
-(IBAction)btnRegisterPressed:(id)sender;

-(void)sendPersonDataToRegisterInfoiewController:(Person *)obj;
@end
#endif /* RegisterInfoViewController_h */
