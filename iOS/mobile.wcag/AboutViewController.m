//
//  AboutViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "AboutViewController.h"
#import "UIColor+PXExtensions.h"

@interface AboutViewController(){
    int aniTime;
    CusTabBarController * tab;
}

@end

@implementation AboutViewController

+ (void) initialize
{

    [[UITabBar appearance] setBarTintColor:[UIColor pxColorWithHexValue:@"4d4d4d"]];
    if ([[UITabBar appearance] respondsToSelector:@selector(setUnselectedItemTintColor:)]) {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.infoBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.infoBtn setTitle:AMLocalizedString(@"InfoBtnText", nil) forState:UIControlStateNormal];
    self.infoBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.infoBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.infoBtn.clipsToBounds = YES;
    self.infoBtn.titleLabel.numberOfLines = 0;
    self.infoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)viewWillAppear:(BOOL)animated
{

    [AppDelegate sharedAppDelegate].viewNum = 1;
    tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.infoBtn setTitle:AMLocalizedString(@"InfoBtnText", nil) forState:UIControlStateNormal];
    self.infoBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    
    [self.textView setText:AMLocalizedString(@"AboutPage", nil)];
    [self.imageView setImage:[UIImage imageNamed:AMLocalizedString(@"Webforall_Banner",nil)]];

    
    self.textView.font = [AppDelegate sharedAppDelegate].textFont;

    [self.navigationItem setHidesBackButton:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnMenuPressed:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem.isAccessibilityElement = YES;
    self.navigationItem.rightBarButtonItem.accessibilityLabel = AMLocalizedString(@"MenuBtnText", nil);
    self.navigationItem.rightBarButtonItem.accessibilityHint = AMLocalizedString(@"MenuBtnText", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"Arial" size:[AppDelegate sharedAppDelegate].navTitleFont]
                                                                      }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController setNavigationBarHidden:NO];

    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"IntroTitle"];


    self.imageView.image = [UIImage imageNamed:AMLocalizedString(@"Webforall_Banner", nil)];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}


-(BOOL)isAccessibilityElement
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMenuPressed:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
}

- (IBAction)btnInfoClick:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"AboutChildViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
}

@end
