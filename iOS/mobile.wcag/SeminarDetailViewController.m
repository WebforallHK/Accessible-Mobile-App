//
//  SeminarDetailViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "SeminarDetailViewController.h"
#import "Seminar.h"
#import "RegisterSeminarViewController.h"
#import "MapViewController.h"
#import "DateUtil.h"


@interface SeminarDetailViewController() {
    CusTabBarController *tab;
}
@end

@implementation SeminarDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    for(int i=1; i<=3; i++)
//    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:leftRecognizer];
//    }

}

-(void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
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
    else if(direction == UIAccessibilityScrollDirectionUp)
    {
        NSLog(@"UIAccessibilityScrollDirectionUp");
        CGPoint topOffset = CGPointMake(0, 0);
        [self.scrollView setContentOffset:topOffset animated:YES];
    }
    else if (direction == UIAccessibilityScrollDirectionDown)
    {
        NSLog(@"UIAccessibilityScrollDirectionDown");
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        [self.scrollView setContentOffset:bottomOffset animated:YES];
    }
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    NSLog(@"seminar Date=%@", [DateUtil dateFromString:[self.seminar getLdate]]);
    
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
    
//    self.navigationItem.title = AMLocalizedString(@"SeminarDetailTitle", nil);
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"SeminarDetailTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self createLayout];

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

-(IBAction) btnMapPressed:(id)sendet
{
    NSString *vcName = @"MapViewController";

    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    MapViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    ivc.seminar = self.seminar;
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction) btnRegisterPressed:(id)sendet
{
    NSString *vcName = @"RegisterSeminarViewController";

    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    RegisterSeminarViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    ivc.seminar = self.seminar;
    [self.navigationController pushViewController:ivc animated:YES];
}

- (void)createLayout {
    
    CGFloat globalX = [AppDelegate sharedAppDelegate].titleX;
    CGFloat globalX2 = 20.0;
    CGFloat globalY = 0;
    CGFloat globalWidth = self.scrollView.frame.size.width-globalX*2;
    CGFloat globalWidth2 = self.scrollView.frame.size.width-globalX2*2;
    
    globalY += 20;
    self.seminarTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.seminarTitleLbl.numberOfLines = 0;
    self.seminarTitleLbl.text = AMLocalizedString([self.seminar getTitle], nil);
    self.seminarTitleLbl.textColor =[UIColor pxColorWithHexValue:@"3f51b5"];
    self.seminarTitleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    self.seminarTitleLbl.textAlignment = NSTextAlignmentCenter;
    self.seminarTitleLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize = [[[NSAttributedString alloc] initWithString:self.seminarTitleLbl.text attributes:@{NSFontAttributeName: self.seminarTitleLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame = self.seminarTitleLbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.seminarTitleLbl.frame = newFrame;
    [self.scrollView addSubview:self.seminarTitleLbl];
    globalY += self.seminarTitleLbl.frame.size.height;
    globalY += 30;
    
    self.dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.dateLbl.text = AMLocalizedString(@"Date:", nil);
    self.dateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize1 = [[[NSAttributedString alloc] initWithString:self.dateLbl.text attributes:@{NSFontAttributeName: self.dateLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame1 = self.dateLbl.frame;
    newFrame1.size.height = expectedLabelSize1.height;
    self.dateLbl.frame = newFrame1;
    [self.scrollView addSubview:self.dateLbl];
    globalY += self.dateLbl.frame.size.height;
    globalY += 5;
    
    self.dateTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.dateTextView.text = [DateUtil formattedDate:[self.seminar getLdate] language:LocalizationGetLanguage isLongDate:YES];
    self.dateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.dateTextView.scrollEnabled = NO;
    CGRect frame = self.dateTextView.frame;
    frame.size.height = [self.dateTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.dateTextView.frame = frame;
    [self.dateTextView setUserInteractionEnabled:NO];
    self.dateTextView.textContainer.lineFragmentPadding = 0;
    self.dateTextView.textContainerInset = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.dateTextView];
    globalY += self.dateTextView.frame.size.height;
    globalY += 20;
    
    self.timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.timeLbl.text = AMLocalizedString(@"Time:", nil);
    self.timeLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize2 = [[[NSAttributedString alloc] initWithString:self.timeLbl.text attributes:@{NSFontAttributeName: self.timeLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame2 = self.timeLbl.frame;
    newFrame2.size.height = expectedLabelSize2.height;
    self.timeLbl.frame = newFrame2;
    [self.scrollView addSubview:self.timeLbl];
    globalY += self.timeLbl.frame.size.height;
    globalY += 5;
    
    self.timeTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.timeTextView.text = AMLocalizedString([self.seminar getTime], nil);
    self.timeTextView.scrollEnabled = NO;
    self.timeTextView.font = [AppDelegate sharedAppDelegate].textFont;
    CGRect frame2 = self.timeTextView.frame;
    frame2.size.height = [self.timeTextView sizeThatFits:CGSizeMake(globalWidth2, MAXFLOAT)].height;
    self.timeTextView.frame = frame2;
    [self.timeTextView setUserInteractionEnabled:NO];
    self.timeTextView.textContainer.lineFragmentPadding = 0;
    self.timeTextView.textContainerInset = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.timeTextView];
    globalY += self.timeTextView.frame.size.height;
    globalY += 20;
    
//    if ([lang isEqualToString:@"en"])
        self.venueLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
//    else
//        self.venueLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX-4, globalY, globalWidth-10, 30)];
    self.venueLbl.text = AMLocalizedString(@"Venue:", nil);
    self.venueLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize3 = [[[NSAttributedString alloc] initWithString:self.venueLbl.text attributes:@{NSFontAttributeName: self.venueLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame3 = self.venueLbl.frame;
    newFrame3.size.height = expectedLabelSize3.height;
    self.venueLbl.frame = newFrame3;
    [self.scrollView addSubview:self.venueLbl];
    globalY += self.venueLbl.frame.size.height;
    globalY += 5;
    
    self.venueTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.venueTextView.text = AMLocalizedString([self.seminar getVenue], nil);
    self.venueTextView.scrollEnabled = NO;
    self.venueTextView.font = [AppDelegate sharedAppDelegate].textFont;
    CGRect frame3 = self.venueTextView.frame;
    frame3.size.height = [self.venueTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.venueTextView.frame = frame3;
    [self.venueTextView setUserInteractionEnabled:NO];
    self.venueTextView.textContainer.lineFragmentPadding = 0;
    self.venueTextView.textContainerInset = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.venueTextView];
    globalY += self.venueTextView.frame.size.height;
    globalY += 10;
    
    self.mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapBtn setFrame:CGRectMake([AppDelegate sharedAppDelegate].buttonX, globalY, self.scrollView.frame.size.width-[AppDelegate sharedAppDelegate].buttonX*2, [AppDelegate sharedAppDelegate].buttonHeight)];
    [self.mapBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.mapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.mapBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    UIImage *img = [UIImage imageNamed:@"btn_map"];
    [self.mapBtn setImage:img forState:UIControlStateNormal];
    self.mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    self.mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.mapBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.mapBtn.clipsToBounds = YES;
    [self.mapBtn setTitle:AMLocalizedString(@"MapBtnText", nil) forState:UIControlStateNormal];
    [self.mapBtn setTintColor:[UIColor whiteColor]];
    [self.mapBtn addTarget:self action:@selector(btnMapPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.mapBtn];
    globalY += self.mapBtn.frame.size.height;
    globalY += 20;
    
    self.detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.detailLbl.text = AMLocalizedString(@"Details:", nil);
    self.detailLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    CGSize expectedLabelSize4 = [[[NSAttributedString alloc] initWithString:self.detailLbl.text attributes:@{NSFontAttributeName: self.detailLbl.font}] boundingRectWithSize:CGSizeMake(globalWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect newFrame4 = self.detailLbl.frame;
    newFrame4.size.height = expectedLabelSize4.height;
    self.detailLbl.frame = newFrame4;
    [self.scrollView addSubview:self.detailLbl];
    globalY += self.detailLbl.frame.size.height;
    globalY += 5;
    
    self.detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, 30)];
    self.detailTextView.text = AMLocalizedString([self.seminar getDetail], nil);
    self.detailTextView.scrollEnabled = NO;
    self.detailTextView.font = [AppDelegate sharedAppDelegate].textFont;
    CGRect frame4 = self.detailTextView.frame;
    frame4.size.height = [self.detailTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.detailTextView.frame = frame4;
    [self.detailTextView setUserInteractionEnabled:NO];
    self.detailTextView.textContainer.lineFragmentPadding = 0;
    self.detailTextView.textContainerInset = UIEdgeInsetsZero;
    [self.scrollView addSubview:self.detailTextView];
    globalY += self.detailTextView.frame.size.height;
    globalY += 10;
    
    if (self.seminar.isPastEvent == NO) {
        self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (isiPad)
            [self.registerBtn setFrame:CGRectMake([AppDelegate sharedAppDelegate].buttonX, globalY, self.scrollView.frame.size.width-[AppDelegate sharedAppDelegate].buttonX*2, 65)];
        else
            [self.registerBtn setFrame:CGRectMake([AppDelegate sharedAppDelegate].buttonX, globalY, self.scrollView.frame.size.width-[AppDelegate sharedAppDelegate].buttonX*2, 45)];
        [self.registerBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
        [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.registerBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
        [self.registerBtn setTitle:AMLocalizedString(@"RegisterSeminarBtnText", nil) forState:UIControlStateNormal];
        self.registerBtn.clipsToBounds = YES;
        self.registerBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
        [self.registerBtn addTarget:self action:@selector(btnRegisterPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.registerBtn];
        globalY += self.registerBtn.frame.size.height;
        globalY += 20;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, globalY+66);
}

- (void)viewDidDisappear:(BOOL)animated {
//    for (UIView *vi in self.scrollView.subviews) {
//        [vi removeFromSuperview];
//    }
    [tab removeFromSuperview];
    [super viewDidDisappear:YES];
}



@end
