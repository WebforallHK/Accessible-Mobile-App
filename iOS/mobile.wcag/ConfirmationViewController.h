//
//  ConfirmationViewController.h
//  mobile.wcag
//
//

#ifndef ConfirmationViewController_h
#define ConfirmationViewController_h


#import <UIKit/UIKit.h>
#import "Person.h"
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@protocol sendDataProtocol <NSObject>

-(void)sendPersonDataToRegisterInfoiewController:(Person *)obj;

@end

@interface ConfirmationViewController : UIViewController

@property(nonatomic, strong) Person *person;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property(nonatomic, strong) IBOutlet UILabel *lastNameLbl;
@property(nonatomic, strong) IBOutlet UILabel *firstNameLbl;
@property(nonatomic, strong) IBOutlet UILabel *addressLbl;
@property(nonatomic, strong) IBOutlet UILabel *districtLbl;
@property(nonatomic, strong) IBOutlet UILabel *phoneLbl;

@property(nonatomic, strong) IBOutlet UITextView *firstNameTextView;
@property(nonatomic, strong) IBOutlet UITextView *lastNameTextView;
@property(nonatomic, strong) IBOutlet UITextView *addressTextView;
@property(nonatomic, strong) IBOutlet UITextView *districtTextView;
@property(nonatomic, strong) IBOutlet UITextView *phoneTextView;
@property(nonatomic, strong) IBOutlet UIButton *confirmBtn;
@property(nonatomic, strong) IBOutlet UIButton *changeInfoBtn;

@property(nonatomic,strong) Seminar *seminar;
@property(nonatomic,assign)id delegate;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnChangeInfoPressed:(id)sender;
-(IBAction)btnConfirmPressed:(id)sender;

@end

#endif /* ConfirmationViewController_h */
