//
//  ViewController.h
//  mobile.wcag
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainScreenViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIImageView *bgImage;
@property (nonatomic,strong) IBOutlet UIButton* startBtn;

-(IBAction)btnStartClick:(id)sender;

@end

