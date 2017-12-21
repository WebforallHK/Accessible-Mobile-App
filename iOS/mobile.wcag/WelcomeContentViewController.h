//
//  WelcomeContentViewController.h
//  mobile.wcag
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "M13Checkbox.h"

#ifndef WelcomeContentViewController_h
#define WelcomeContentViewController_h

@interface WelcomeContentViewController : UIViewController

@property  NSUInteger pageIndex;
@property  NSString *imgFile;
@property  NSString *txtTitle;
@property (strong, nonatomic) IBOutlet UIImageView *ivScreenImage;
@property (strong, nonatomic) IBOutlet UILabel *lblScreenLabel;
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UIButton *btnSkip;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnRight;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnLeft;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (strong, nonatomic) IBOutlet UILabel *lblNotShow;
@property (strong, nonatomic) IBOutlet UILabel *tutorialLabel;
@property (nonatomic, strong) M13Checkbox *checkbox;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction)btnSkipClick:(id)sender;
- (IBAction)changePage:(id)sender;
@end
#endif /* WelcomeContentViewController_h */
