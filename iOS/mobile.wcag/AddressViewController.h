//
//  AddressViewController.h
//  mobile.wcag
//
//

#ifndef AddressViewController_h
#define AddressViewController_h
#import "AppDelegate.h"
#import "Seminar.h"
#import "CusTabBarController.h"

@interface AddressViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel *addressLbl;
@property(nonatomic, strong) IBOutlet UITextView  *addressTextView;
@property(nonatomic, strong) NSString *address;

@property(nonatomic, strong) Seminar *seminar;

@end

#endif /* AddressViewController_h */
