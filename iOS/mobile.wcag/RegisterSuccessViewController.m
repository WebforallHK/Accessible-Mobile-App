//
//  RegisterSuccessViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "RegisterSuccessViewController.h"
#import "DateUtil.h"

@interface RegisterSuccessViewController() {
    CusTabBarController * tab;
}
@end

@implementation RegisterSuccessViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)loadNavigation
{
    
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
}

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self loadNavigation];
    
    
    [self createLayout];
    
    
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.seminarTitleLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.seminarTitleLbl.textAlignment = NSTextAlignmentCenter;
    self.dateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.timeLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.venueLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.dateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.timeTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.venueTextView.font = [AppDelegate sharedAppDelegate].textFont;
    
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*2)];
    self.descLbl.text = AMLocalizedString(@"You have been register in the following seminar:", nil);
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.descLbl.numberOfLines = 0;
    CGSize expectedLabelSize = [[[NSAttributedString alloc] initWithString:self.descLbl.text attributes:@{NSFontAttributeName: self.descLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame = self.descLbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.descLbl.frame = newFrame;
    [self.scrollView addSubview:self.descLbl];
    globalY += self.descLbl.frame.size.height + spacingY;
    
    self.seminarTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, [AppDelegate sharedAppDelegate].titleFont.pointSize*2*4)];
    self.seminarTitleLbl.numberOfLines = 0;
    self.seminarTitleLbl.text = AMLocalizedString([self.seminar getTitle], nil);
    self.seminarTitleLbl.textColor = [UIColor pxColorWithHexValue:@"3f51b5"];
    self.seminarTitleLbl.textAlignment = NSTextAlignmentCenter;
    self.seminarTitleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [self.scrollView addSubview:self.seminarTitleLbl];
    globalY += self.seminarTitleLbl.frame.size.height;
    
    self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.dateLbl.text = AMLocalizedString(@"Date:", nil);
    [self.scrollView addSubview:self.dateLbl];
    globalY += self.dateLbl.frame.size.height + spacingLY;
    
    self.dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.dateTextView.text = [DateUtil formattedDate:[self.seminar getLdate] language:LocalizationGetLanguage isLongDate:YES];
    [self.scrollView addSubview:self.dateTextView];
    globalY += self.dateTextView.frame.size.height + spacingY;
    
    self.timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.timeLbl.text = AMLocalizedString(@"Time:", nil);
    [self.scrollView addSubview:self.timeLbl];
    globalY += self.timeLbl.frame.size.height + spacingLY;
    
    self.timeTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.timeTextView.text = [self.seminar getTime];
    [self.scrollView addSubview:self.timeTextView];
    globalY += self.timeTextView.frame.size.height + spacingY;
    
    self.venueLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.venueLbl.text = AMLocalizedString(@"Venue:", nil);
    self.venueLbl.numberOfLines = 0;
    [self.scrollView addSubview:self.venueLbl];
    globalY += self.venueLbl.frame.size.height + spacingLY;
    
    self.venueTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*5)];
    self.venueTextView.text = AMLocalizedString([self.seminar getVenue], nil);
    self.venueTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.venueTextView.scrollEnabled = NO;
    CGRect frame = self.venueTextView.frame;
    frame.size.height = [self.venueTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.venueTextView.frame = frame;
    [self.scrollView addSubview:self.venueTextView];
    globalY += self.venueTextView.frame.size.height + spacingY*2;
    
    self.homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.homeBtn.frame = CGRectMake(globalX, globalY, globalWidth, [AppDelegate sharedAppDelegate].buttonHeight);
    [self.homeBtn addTarget:self action:@selector(btnHomePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.homeBtn];
    globalY += self.self.homeBtn.frame.size.height+spacingY*2;
    
    [self.view bringSubviewToFront:tab];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, globalY + [AppDelegate sharedAppDelegate].tabbarHeight+150);
    
    self.timeTextView.scrollEnabled = NO;
    self.venueTextView.scrollEnabled = NO;
    self.dateTextView.scrollEnabled = NO;
    self.timeTextView.editable = NO;
    self.venueTextView.editable = NO;
    self.dateTextView.editable = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
