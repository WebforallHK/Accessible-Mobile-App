//
//  RegisterSeminarViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "RegisterSeminarViewController.h"
#import "RegisterInfoViewController.h"
#import "DateUtil.h"

@interface RegisterSeminarViewController() {
    CusTabBarController * tab;
}
@end

@implementation RegisterSeminarViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.nextBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.nextBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.nextBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.nextBtn.clipsToBounds = YES;
    
    for(int i=1; i<=3; i++)
    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:i];
        [self.view addGestureRecognizer:leftRecognizer];
    }
    
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSUInteger touches = gestureRecognizer.numberOfTouches;
    switch (touches) {
        case 1:
            [self.navigationController popViewControllerAnimated:NO];
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
}

-(BOOL)accessibilityScroll:(UIAccessibilityScrollDirection)direction
{
    if(direction == UIAccessibilityScrollDirectionLeft)
        [self.navigationController popViewControllerAnimated:NO];
    return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem.isAccessibilityElement = YES;
    self.navigationItem.leftBarButtonItem.accessibilityLabel = AMLocalizedString(@"BackBtnText", nil);
    self.navigationItem.leftBarButtonItem.accessibilityHint = AMLocalizedString(@"BackBtnText", nil);
    self.navigationItem.leftBarButtonItem.tag = 0;
    
    
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
    
//    self.navigationItem.title = AMLocalizedString(@"RegisterSeminarTitle", nil);
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"RegisterSeminarTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self createLayout];
    
    self.descLbl.text = AMLocalizedString(@"You would like to register for the following seminar:", nil);
    self.descLbl.numberOfLines = 0;
    self.seminarTitleLbl.text = AMLocalizedString(@"Seminar:", nil);
    self.dateLbl.text = AMLocalizedString(@"Date:", nil);
    self.timeLbl.text = AMLocalizedString(@"Time:", nil);
    self.venueLbl.text = AMLocalizedString(@"Venue:", nil);
    
    self.seminarTitleTextView.text = AMLocalizedString([self.seminar getTitle], nil);
    self.seminarTitleTextView.textColor = [UIColor pxColorWithHexValue:@"3f51b5"];
    self.seminarTitleTextView.textAlignment = NSTextAlignmentCenter;
    self.dateTextView.text = [DateUtil formattedDate:[self.seminar getLdate] language:LocalizationGetLanguage isLongDate:YES];
    self.timeTextView.text = AMLocalizedString([self.seminar getTime], nil);
    
    
    [self.nextBtn setTitle:AMLocalizedString(@"NextBtnText", nil) forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.nextBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.nextBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.nextBtn.clipsToBounds = YES;
    
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.seminarTitleLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.dateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.timeLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.venueLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.seminarTitleTextView.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.dateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.timeTextView.font = [AppDelegate sharedAppDelegate].textFont;
    
    
    self.seminarTitleTextView.scrollEnabled = NO;
    self.dateTextView.scrollEnabled = NO;
    self.timeTextView.scrollEnabled = NO;
    self.venueTextView.scrollEnabled = NO;
    
    
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


-(IBAction)btnNextPressed:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    RegisterInfoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterInfoViewController"];
    ivc.seminar = self.seminar;
    ivc.canBack = YES;
    [self.navigationController pushViewController:ivc animated:YES];
}

- (void)createLayout {
    CGFloat globalX = [AppDelegate sharedAppDelegate].titleX;
    CGFloat globalY = 0;
    CGFloat globalWidth = self.view.frame.size.width-globalX*2;
    CGFloat globalHeight = [AppDelegate sharedAppDelegate].textFont.pointSize*2;
    CGFloat spacingY = [AppDelegate sharedAppDelegate].spacingY;
    CGFloat spacingLY = [AppDelegate sharedAppDelegate].spacingLY;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    globalY += globalX;
    self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*2)];
    [self.scrollView addSubview:self.descLbl];
    globalY += self.descLbl.frame.size.height+spacingY;
    
    self.seminarTitleTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*3)];
    [self.scrollView addSubview:self.seminarTitleTextView];
    globalY += self.seminarTitleTextView.frame.size.height+spacingY*2;
    
    self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.dateLbl];
    globalY += self.dateLbl.frame.size.height +spacingLY;
    
    self.dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.dateTextView];
    globalY += self.dateTextView.frame.size.height +spacingY;
    
    self.timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.timeLbl];
    globalY += self.timeLbl.frame.size.height +spacingLY;
    
    self.timeTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.timeTextView];
    globalY += self.timeTextView.frame.size.height +spacingY;
    
    self.venueLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.venueLbl];
    globalY += self.venueLbl.frame.size.height +spacingLY;
    
    self.venueTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*4)];
    self.venueTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.venueTextView.text = AMLocalizedString([self.seminar getVenue], nil);
    CGRect frame = self.venueTextView.frame;
    frame.size.height = [self.venueTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.venueTextView.frame = frame;
    [self.scrollView addSubview:self.venueTextView];
    globalY += self.venueTextView.frame.size.height +spacingY;
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(globalX, globalY, globalWidth, [AppDelegate sharedAppDelegate].buttonHeight);
    [self.nextBtn addTarget:self action:@selector(btnNextPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.nextBtn];
    globalY += self.nextBtn.frame.size.height + 30;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, globalY+[AppDelegate sharedAppDelegate].tabbarHeight+100);
    
    self.timeTextView.scrollEnabled = NO;
    self.dateTextView.scrollEnabled = NO;
    self.venueTextView.scrollEnabled = NO;
    self.seminarTitleTextView.scrollEnabled = NO;
    self.timeTextView.editable = NO;
    self.dateTextView.editable = NO;
    self.venueTextView.editable = NO;
    self.seminarTitleTextView.editable = NO;
    
    [self.view bringSubviewToFront:tab];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self.scrollView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [tab removeFromSuperview];
}

@end
