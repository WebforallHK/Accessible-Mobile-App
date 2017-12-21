//
//  RegisterSuccessBySearchViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "RegisterSuccessBySearchViewController.h"
#import "DateUtil.h"

@interface RegisterSuccessBySearchViewController() {
    CusTabBarController *tab;
}
@end

@implementation RegisterSuccessBySearchViewController

-(void)viewDidLoad
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    
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
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"RegisterSuccessTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self createLayout];
    
    
    self.startDateLbl.text = AMLocalizedString(@"Start Date:", nil);
    self.endDateLbl.text = AMLocalizedString(@"End Date:", nil);
    self.startDateTextView.text = [self.seminar getStartDateStr];
    self.endDateTextView.text = [self.seminar getEndDateStr];
    self.startDateTextView.scrollEnabled = NO;
    self.endDateTextView.scrollEnabled = NO;
    
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.descTxv.font = [AppDelegate sharedAppDelegate].textFont;
    self.startDateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.endDateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;

    self.startDateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.endDateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    
    [self.homeBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.homeBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    self.homeBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.homeBtn.clipsToBounds = YES;
    [self.homeBtn setTitle:[NSString stringWithFormat:@"%@", AMLocalizedString(@"HomeBtnText", nil)] forState:UIControlStateNormal];
    self.homeBtn.isAccessibilityElement = YES;
    self.homeBtn.accessibilityLabel = AMLocalizedString(@"HomeBtnText", nil);
    self.homeBtn.accessibilityHint = AMLocalizedString(@"Double Tap to go to home page", nil);
    
    [self.navigationItem setHidesBackButton:YES];
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

- (IBAction) btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)btnHomePressed:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
    [nc popToRootViewControllerAnimated:NO];
    [self.navigationController pushViewController:ivc animated:YES];
}

- (void)createLayout {
    CGFloat globalX = [AppDelegate sharedAppDelegate].titleX;
    CGFloat globalY = 0;
    CGFloat globalWidth = self.view.frame.size.width-globalX*2;
    CGFloat globalHeight = [AppDelegate sharedAppDelegate].textFont.pointSize*2;
    CGFloat spacingY = [AppDelegate sharedAppDelegate].spacingY;
    CGFloat spacingLY = [AppDelegate sharedAppDelegate].spacingLY;
    
    globalY += globalX;
    self.descTxv = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*3)];
    [self.descTxv setText:AMLocalizedString(@"successDesc", nil)];
    self.descTxv.font = [AppDelegate sharedAppDelegate].textFont;
    [self.view addSubview:self.descTxv];
    globalY += self.descTxv.frame.size.height+spacingY;
    
    self.startDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.view addSubview:self.startDateLbl];
    globalY += self.startDateLbl.frame.size.height+spacingLY;
    
    self.startDateTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.view addSubview:self.startDateTextView];
    globalY += self.startDateTextView.frame.size.height +spacingY;
    
    self.endDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.view addSubview:self.endDateLbl];
    globalY += self.endDateLbl.frame.size.height+spacingLY;
    
    self.endDateTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.view addSubview:self.endDateTextView];
    globalY += self.endDateTextView.frame.size.height +spacingY;
    
    self.homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    self.homeBtn.frame = CGRectMake(globalX, self.view.frame.size.height-[AppDelegate sharedAppDelegate].tabbarHeight-[AppDelegate sharedAppDelegate].buttonHeight-100, globalWidth, [AppDelegate sharedAppDelegate].buttonHeight);
    [self.homeBtn addTarget:self action:@selector(btnHomePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.homeBtn];
    globalY += self.homeBtn.frame.size.height + 30;
    
    self.descTxv.scrollEnabled = NO;
    self.endDateTextView.scrollEnabled = NO;
    self.startDateTextView.scrollEnabled = NO;
    self.descTxv.editable = NO;
    self.endDateTextView.editable = NO;
    self.startDateTextView.editable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
