//
//  WelcomeContentViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "WelcomeContentViewController.h"
#import "UIColor+PXExtensions.h"
#import "MenuViewController.h"

@interface WelcomeContentViewController()

@end

@implementation WelcomeContentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lblScreenLabel.text = self.txtTitle;
    self.lblScreenLabel.font = [AppDelegate sharedAppDelegate].textFont;
    //[btnRight setAction:@selector(menuBtnClick:)];
    
    self.pageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageCtrl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageCtrl.backgroundColor = [UIColor whiteColor];
    
    if (isiPad)
        self.checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(self.btnSkip.frame.origin.x, self.btnSkip.frame.origin.y-self.btnSkip.frame.size.height-50, self.view.frame.size.width - 40, 20)];
    else
        self.checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(self.btnSkip.frame.origin.x, CGRectGetMidY(self.btnSkip.frame)-150, self.view.frame.size.width - 40, 20)];
    self.checkbox.titleLabel.text = AMLocalizedString(@"NotShowText", nil);
    self.checkbox.titleLabel.font = [AppDelegate sharedAppDelegate].textFont;
    self.checkbox.checkAlignment = M13CheckboxAlignmentLeft;
    self.checkbox.contentMode = UIViewContentModeCenter;
    [self.checkbox autoFitWidthToText];
    self.checkbox.isAccessibilityElement = YES;
    self.checkbox.accessibilityHint = AMLocalizedString(@"NotShowTextns", nil);
    self.checkbox.accessibilityLabel = AMLocalizedString(@"NotShowTextns", nil);
    [self.checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkbox];

    if (isiPad) {
        [self.tutorialLabel setFrame:CGRectMake(37.0*[[UIScreen mainScreen] bounds].size.width/320, CGRectGetMaxY(self.ivScreenImage.frame)+10, 245.0*[[UIScreen mainScreen] bounds].size.width/320, 94.0*[[UIScreen mainScreen] bounds].size.height/667)];
    } else {
        [self.tutorialLabel setFrame:CGRectMake(37.0*[[UIScreen mainScreen] bounds].size.width/320, self.checkbox.frame.origin.y-60, 245.0*[[UIScreen mainScreen] bounds].size.width/320, 74.0*[[UIScreen mainScreen] bounds].size.height/667)];
    }
    self.tutorialLabel.font = [AppDelegate sharedAppDelegate].textFont;
    self.tutorialLabel.numberOfLines = 0;
    if (isiPad)
        [self.pageCtrl setFrame:CGRectMake(self.view.frame.size.width/2-(371/2), CGRectGetMaxY(self.tutorialLabel.frame)  + 50, 371, 37)];
    else
        [self.pageCtrl setFrame:CGRectMake(self.view.frame.size.width/2-(371/2), self.tutorialLabel.frame.origin.y+20  + 90, 371, 37)];
    
    self.pageCtrl.accessibilityTraits = self.accessibilityTraits | UIAccessibilityTraitAdjustable;
    

}


-(void)viewWillAppear:(BOOL)animated
{
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self.tutorialLabel setText:AMLocalizedString(@"TutorialLblText", nil)];
    self.txtView.textAlignment = NSTextAlignmentLeft;
    if([self.txtTitle isEqualToString:@"Page 1"])
    {
        [self.txtView setHidden:NO];
        [self.ivScreenImage setHidden:YES];
        [self.txtView setText:AMLocalizedString(@"WelcomePage1", nil)];
        self.pageCtrl.currentPage = 0;
        self.tutorialLabel.hidden = YES;
        //[txtView setFont:[UIFont fontWithName:@"" size:14.0]];
    }
    else if([self.txtTitle isEqualToString:@"Page 2"])
    {
        [self.txtView setHidden:YES];
        [self.ivScreenImage setHidden:NO];
        self.ivScreenImage.image = [UIImage imageNamed:@"tutorial1.jpg"];
        self.pageCtrl.currentPage = 1;
        self.tutorialLabel.hidden = NO;
        [self.txtView setText:@""];
        self.txtView.font = [AppDelegate sharedAppDelegate].textFont;
        self.ivScreenImage.tag = 101;
        self.tutorialLabel.tag = 102;
        self.pageCtrl.tag = 103;
    }
    self.txtView.font = [AppDelegate sharedAppDelegate].textFont;
    
    [self.btnSkip setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnSkip setTitle:AMLocalizedString(@"SkipBtnText", nil) forState:UIControlStateNormal];
    self.btnSkip.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    self.btnSkip.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.btnSkip.clipsToBounds = YES;
    
}
 

- (IBAction)btnMenuPressed:(id)sender {
   // [self.scrollView setContentOffset:CGPointMake(self.pageControl.currentPage*CGRectGetWidth(self.view.frame), 0) animated:YES];
    NSLog(@"menuBtnClick");
}

- (IBAction)btnSkipClick:(id)sender {
    if(self.checkbox.checkState == true){
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"skipWelcome"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    UIStoryboard *storyboard;
    if (isiPad) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
    //NSLog(@"skipBtnClick");
}

- (IBAction)changePage:(id)sender {
    UIPageControl *pager=sender;
    NSInteger page = pager.currentPage;
    //NSLog(@"page=%ld", (long)page);
    if(page == 0)
    {
        [self.txtView setHidden:NO];
        [self.ivScreenImage setHidden:YES];
        [self.txtView setText:AMLocalizedString(@"WelcomePage1", nil)];
        self.tutorialLabel.hidden = YES;
    }
    else
    {
        [self.txtView setHidden:YES];
        [self.ivScreenImage setHidden:NO];
        self.ivScreenImage.image = [UIImage imageNamed:@"tutorial1.jpg"];
        self.tutorialLabel.hidden = NO;
        [self.txtView setText:@""];
        self.ivScreenImage.tag = 101;
        self.tutorialLabel.tag = 102;
        self.pageCtrl.tag = 103;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkboxClick:(id)sender {
    if (self.checkbox.checkState == M13CheckboxStateUnchecked) {
        self.checkbox.accessibilityHint = AMLocalizedString(@"NotShowTextns", nil);
        self.checkbox.accessibilityLabel = AMLocalizedString(@"NotShowTextns", nil);
    } else if (self.checkbox.checkState == M13CheckboxStateChecked) {
        self.checkbox.accessibilityHint = AMLocalizedString(@"NotShowTexts", nil);
        self.checkbox.accessibilityLabel = AMLocalizedString(@"NotShowTexts", nil);
    }
}

- (UIAccessibilityTraits)accessibilityTraits
{
    return super.accessibilityTraits | UIAccessibilityTraitAdjustable;
}

- (void)accessibilityIncrement
{
    NSLog(@"acc+");
    self.pageCtrl.currentPage = self.pageCtrl.currentPage + 1;
    [self.pageCtrl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)accessibilityDecrement
{
    NSLog(@"acc-");
    self.pageCtrl.currentPage = self.pageCtrl.currentPage - 1;
    [self.pageCtrl sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
