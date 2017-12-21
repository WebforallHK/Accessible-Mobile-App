//
//  SeminarDetailViewController.h
//  mobile.wcag
//
//

#ifndef SeminarDetailViewController_h
#define SeminarDetailViewController_h
@import UIKit;
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface SeminarDetailViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel *seminarTitleLbl;
@property(nonatomic, strong) IBOutlet UILabel *dateLbl;
@property(nonatomic, strong) IBOutlet UITextView *dateTextView;
@property(nonatomic, strong) IBOutlet UILabel *timeLbl;
@property(nonatomic, strong) IBOutlet UITextView *timeTextView;
@property(nonatomic, strong) IBOutlet UILabel *venueLbl;
@property(nonatomic, strong) IBOutlet UITextView *venueTextView;
@property(nonatomic, strong) IBOutlet UIButton *mapBtn;
@property(nonatomic, strong) IBOutlet UILabel *detailLbl;
@property(nonatomic, strong) IBOutlet UITextView *detailTextView;
@property(nonatomic, strong) IBOutlet UIButton *registerBtn;
@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property(nonatomic, strong) Seminar *seminar;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction) btnBackPressed:(id)sender;
-(IBAction)btnMapPressed:(id)sender;
-(IBAction)btnRegisterPressed:(id)sender;

@end

#endif /* SeminarDetailViewController_h */
