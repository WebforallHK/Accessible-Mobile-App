//
//  ViewController.m
//  mobile.wcag
//
//

#import "MainScreenViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.startBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.startBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    self.startBtn.clipsToBounds = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    self.bgImage.tag = 0;
    self.bgImage.isAccessibilityElement = YES;
    self.bgImage.accessibilityLabel = AMLocalizedString(@"Web or Mobile App Accessibility Campaign", nil);
    self.bgImage.accessibilityHint = AMLocalizedString(@"Web or Mobile App Accessibility Campaign", nil);
    self.bgImage.image = [UIImage imageNamed:AMLocalizedString(@"landing", nil)];
    self.startBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    [self.navigationController  setNavigationBarHidden:YES];
    [self.startBtn setTitle:[NSString stringWithFormat:@"%@", AMLocalizedString(@"StartBtnText", nil)] forState:UIControlStateNormal];
    self.startBtn.tag = 1;
    self.startBtn.isAccessibilityElement = YES;
    self.startBtn.accessibilityLabel = AMLocalizedString(@"StartBtnText", nil);
    self.startBtn.accessibilityHint = AMLocalizedString(@"Double Tap to go to Welcome Page", nil);
    
    self.tabBarController.tabBar.hidden = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] <= 11.0)
    {
        // Load resources for iOS 7 or later
    }
    else
    {
        // Load resources for iOS 6.1 or later
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AMLocalizedString(@"versionAlert", nil) message:nil delegate:self cancelButtonTitle:AMLocalizedString(@"va1", nil) otherButtonTitles:nil];
        [alert show];
    }
    if (isiPad) {
        NSLog(@"Screen width phy:%f",[UIScreen mainScreen].nativeBounds.size.width);
        NSLog(@"Screen width:%f",[UIScreen mainScreen].bounds.size.width);
        CGFloat physcialScreenWidth = [UIScreen mainScreen].nativeBounds.size.width;
        if (physcialScreenWidth == 2048.0) {
            self.bgImage.image = [UIImage imageNamed:AMLocalizedString(@"iPadSI12", nil)];
        } else if (physcialScreenWidth == 1668.0) {
            self.bgImage.image = [UIImage imageNamed:AMLocalizedString(@"iPadSI10", nil)];
        } else {
            self.bgImage.image = [UIImage imageNamed:AMLocalizedString(@"iPadSI9", nil)];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnStartClick:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"skipWelcome"] isEqualToString:@"YES"]) {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController pushViewController:ivc animated:YES];
    } else {
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"WelcomePageViewController"];
        [self.navigationController pushViewController:ivc animated:YES];
    }
    
}



@end
