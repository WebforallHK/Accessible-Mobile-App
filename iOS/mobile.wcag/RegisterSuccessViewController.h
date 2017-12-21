//
//  RegisterSuccessViewController.h
//  mobile.wcag
//
//

#ifndef RegisterSuccessViewController_h
#define RegisterSuccessViewController_h

#import <UIKit/UIKit.h>
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface RegisterSuccessViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property(nonatomic, strong) IBOutlet UILabel *seminarTitleLbl;
@property(nonatomic, strong) IBOutlet UILabel *dateLbl;
@property(nonatomic, strong) IBOutlet UILabel *timeLbl;
@property(nonatomic, strong) IBOutlet UILabel *venueLbl;

@property(nonatomic, strong) IBOutlet UITextView *dateTextView;
@property(nonatomic, strong) IBOutlet UITextView *timeTextView;
@property(nonatomic, strong) IBOutlet UITextView *venueTextView;
@property(nonatomic, strong) IBOutlet UIButton *homeBtn;

@property(nonatomic,strong) Seminar *seminar;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnHomePressed:(id)sender;

@end

#endif /* RegisterSuccessViewController_h */
