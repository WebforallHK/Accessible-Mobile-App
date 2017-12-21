//
//  ConfirmationViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "ConfirmationViewController.h"
#import "RegisterInfoViewController.h"
#import "RegisterSuccessViewController.h"
#import "RegisterSuccessBySearchViewController.h"

@interface ConfirmationViewController() {
    CusTabBarController * tab;
}
@end

@implementation ConfirmationViewController

-(void)viewDidLoad
{
}

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    
    // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed:)];
    // [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    // self.navigationItem.leftBarButtonItem.isAccessibilityElement = YES;
    // self.navigationItem.leftBarButtonItem.accessibilityLabel = AMLocalizedString(@"BackBtnText", nil);
    // self.navigationItem.leftBarButtonItem.accessibilityHint = AMLocalizedString(@"BackBtnText", nil);
    // self.navigationItem.leftBarButtonItem.tag = 0;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem.enabled = NO;
//    self.navigationItem.leftBarButtonItem.isAccessibilityElement = NO;
    
    
    
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
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"ConfirmationTitle"];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self createLayout];
    
    
    self.firstNameLbl.text = AMLocalizedString(@"First Name", nil);
    self.lastNameLbl.text = AMLocalizedString(@"Last Name", nil);
    self.addressLbl.text = AMLocalizedString(@"Address", nil);
    self.districtLbl.text = AMLocalizedString(@"District", nil);
    self.phoneLbl.text = AMLocalizedString(@"Phone", nil);
    
    self.districtTextView.text = [self.person getDistrict];
    self.phoneTextView.text = [self.person getPhone];
    
    self.descLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.lastNameLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.firstNameLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.addressLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.districtLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.phoneLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.firstNameTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.lastNameTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.addressTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.districtTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.phoneTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.firstNameTextView.textColor = [UIColor pxColorWithHexValue:@"#303F9E"];
    self.lastNameTextView.textColor = [UIColor pxColorWithHexValue:@"#303F9E"];
    self.addressTextView.textColor = [UIColor pxColorWithHexValue:@"#303F9E"];
    self.districtTextView.textColor = [UIColor pxColorWithHexValue:@"#303F9E"];
    self.phoneTextView.textColor = [UIColor pxColorWithHexValue:@"#303F9E"];
    
    [self.confirmBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.confirmBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.confirmBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.confirmBtn.clipsToBounds = YES;
    [self.changeInfoBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.changeInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.changeInfoBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.changeInfoBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.changeInfoBtn.clipsToBounds = YES;
    
    [self.confirmBtn setTitle:[NSString stringWithFormat:@"%@", AMLocalizedString(@"ConfirmBtnText", nil)] forState:UIControlStateNormal];
    self.confirmBtn.isAccessibilityElement = YES;
    self.confirmBtn.accessibilityLabel = AMLocalizedString(@"ConfirmBtnText", nil);
    self.confirmBtn.accessibilityHint = AMLocalizedString(@"Double Tap to confirm", nil);
    
    [self.changeInfoBtn setTitle:[NSString stringWithFormat:@"%@", AMLocalizedString(@"ChangeInfoBtnText", nil)] forState:UIControlStateNormal];
    self.changeInfoBtn.isAccessibilityElement = YES;
    self.changeInfoBtn.accessibilityLabel = AMLocalizedString(@"ChangeInfoBtnText", nil);
    self.changeInfoBtn.accessibilityHint = AMLocalizedString(@"Double Tap to change information page", nil);
    
    self.navigationItem.hidesBackButton = YES;
    
//    if (isiPad)
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height+400);
//    else
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height+200);
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

-(IBAction)btnChangeInfoPressed:(id)sender
{

    [self.delegate sendPersonDataToRegisterInfoiewController:self.person];
    [self.navigationController popViewControllerAnimated:YES];
//    UIStoryboard *storyboard;
//    if (isiPad) {
//        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
//    } else {
//        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    }
//    RegisterInfoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterInfoViewController"];
//    ivc.canBack = NO;
//    [self.navigationController popToViewController:ivc animated:YES];
    
//    UIStoryboard *storyboard;
//    if (isiPad) {
//        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
//    } else {
//        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    }
//    RegisterInfoViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterInfoViewController"];
//    ivc.person = self.person;
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
//    [nc popToRootViewControllerAnimated:NO];
//    [AppDelegate sharedAppDelegate].window.rootViewController = nc;
}

-(IBAction)btnConfirmPressed:(id)sender
{
    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    if([self.seminar getIsBookingByDate])
    {
        RegisterSuccessBySearchViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterSuccessBySearchViewController"];
        ivc.seminar = self.seminar;
        [self.navigationController pushViewController:ivc animated:YES];
    }
    else
    {
        RegisterSuccessViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterSuccessViewController"];
        ivc.seminar = self.seminar;
        [self.navigationController pushViewController:ivc animated:YES];
    }
}

-(void)createLayout {
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
    
    if ([[UIScreen mainScreen] bounds].size.width < 375)
        self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*1.5)];
    else
        self.descLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    self.descLbl.numberOfLines = 0;
    self.descLbl.text = AMLocalizedString(@"Please confirm your information:", nil);
    [self.scrollView addSubview:self.descLbl];
    globalY += self.descLbl.frame.size.height + spacingY;
    
    self.firstNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.firstNameLbl];
    globalY += self.firstNameLbl.frame.size.height + spacingLY;
    
    self.firstNameTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*5)];
    self.firstNameTextView.text = [self.person getFirstName];
    self.firstNameTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.firstNameTextView.scrollEnabled = NO;
    CGRect frame0 = self.firstNameTextView.frame;
    frame0.size.height = [self.firstNameTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.firstNameTextView.frame = frame0;
    [self.scrollView addSubview:self.firstNameTextView];
    globalY += self.firstNameTextView.frame.size.height + spacingY;
    
    self.lastNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.lastNameLbl];
    globalY += self.lastNameLbl.frame.size.height + spacingLY;
    
    self.lastNameTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*5)];
    self.lastNameTextView.text = [self.person getLastName];
    self.lastNameTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.lastNameTextView.scrollEnabled = NO;
    CGRect frame1 = self.lastNameTextView.frame;
    frame1.size.height = [self.lastNameTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.lastNameTextView.frame = frame1;
    [self.scrollView addSubview:self.lastNameTextView];
    globalY += self.lastNameTextView.frame.size.height + spacingY;
    
    self.addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.addressLbl];
    globalY += self.addressLbl.frame.size.height + spacingLY;
    
    self.addressTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight*5)];
    self.addressTextView.text = [self.person getAddress];
    self.addressTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.addressTextView.scrollEnabled = NO;
    CGRect frame = self.addressTextView.frame;
    frame.size.height = [self.addressTextView sizeThatFits:CGSizeMake(globalWidth, MAXFLOAT)].height;
    self.addressTextView.frame = frame;
    [self.scrollView addSubview:self.addressTextView];
    globalY += self.addressTextView.frame.size.height + spacingY;
    
    self.districtLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.districtLbl];
    globalY += self.districtLbl.frame.size.height + spacingLY;
    
    self.districtTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.districtTextView];
    globalY += self.districtTextView.frame.size.height + spacingY;
    
    self.phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.phoneLbl];
    globalY += self.phoneLbl.frame.size.height + spacingLY;
    
    self.phoneTextView = [[UITextView alloc] initWithFrame:CGRectMake(globalX, globalY, globalWidth, globalHeight)];
    [self.scrollView addSubview:self.phoneTextView];
    globalY += self.phoneTextView.frame.size.height + spacingY*3;
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(globalX, globalY, globalWidth, [AppDelegate sharedAppDelegate].buttonHeight);
    [self.confirmBtn addTarget:self action:@selector(btnConfirmPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.confirmBtn];
    globalY += self.self.confirmBtn.frame.size.height+spacingY*2;
    
    self.changeInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeInfoBtn.frame = CGRectMake(globalX, globalY, globalWidth, [AppDelegate sharedAppDelegate].buttonHeight);
    [self.changeInfoBtn addTarget:self action:@selector(btnChangeInfoPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.changeInfoBtn];
    globalY += self.changeInfoBtn.frame.size.height;
    
    [self.view bringSubviewToFront:tab];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, globalY + [AppDelegate sharedAppDelegate].tabbarHeight+150);
    
    self.firstNameTextView.scrollEnabled = NO;
    self.lastNameTextView.scrollEnabled = NO;
    self.addressTextView.scrollEnabled = NO;
    self.districtTextView.scrollEnabled = NO;
    self.phoneTextView.scrollEnabled = NO;
    self.firstNameTextView.editable = NO;
    self.lastNameTextView.editable = NO;
    self.addressTextView.editable = NO;
    self.districtTextView.editable = NO;
    self.phoneTextView.editable = NO;
//    self.addressTextView.textContainer.lineFragmentPadding = 0;
//    self.addressTextView.textContainerInset = UIEdgeInsetsZero;
//    self.phoneTextView.textContainerInset = UIEdgeInsetsZero;
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
