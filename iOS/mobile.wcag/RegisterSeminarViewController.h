//
//  RegisterSeminarViewController.h
//  mobile.wcag
//
//

#ifndef RegisterSeminarViewController_h
#define RegisterSeminarViewController_h
#import <UIKit/UIKit.h>
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface RegisterSeminarViewController : UIViewController

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UILabel *descLbl;
@property(nonatomic, strong) IBOutlet UILabel *seminarTitleLbl;
@property(nonatomic, strong) IBOutlet UILabel *dateLbl;
@property(nonatomic, strong) IBOutlet UILabel *timeLbl;
@property(nonatomic, strong) IBOutlet UILabel *venueLbl;
@property(nonatomic, strong) IBOutlet UITextView *seminarTitleTextView;
@property(nonatomic, strong) IBOutlet UITextView *dateTextView;
@property(nonatomic, strong) IBOutlet UITextView *timeTextView;
@property(nonatomic, strong) IBOutlet UITextView *venueTextView;
@property(nonatomic, strong) IBOutlet UIButton *nextBtn;
@property(nonatomic, strong) Seminar *seminar;

- (IBAction)btnMenuPressed:(id)sender;
- (IBAction) btnBackPressed:(id)sender;
-(IBAction)btnNextPressed:(id)sender;

@end

#endif /* RegisterSeminarViewController_h */
