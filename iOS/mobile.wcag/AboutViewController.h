//
//  AboutViewController.h
//  mobile.wcag
//
//

#ifndef AboutViewController_h
#define AboutViewController_h
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

#define TIMER_COUNT 5

@interface AboutViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIButton *infoBtn;
@property(nonatomic, weak) IBOutlet UITextView *textView;
@property(nonatomic, weak) IBOutlet UIImageView *imageView;

@end
#endif /* AboutViewController_h */
