//
//  SeminarDetailViewController.m
//  mobile.wcag
//
//  Created by Eric Lai on 8/9/2017.
//  Copyright © 2017 Eric Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeminarDetailViewController.h"
#import "Seminar.h"
#import "RegisterSeminarViewController.h"
#import "MapViewController.h"
#import "DateUtil.h"


@interface SeminarDetailViewController()
@end

@implementation SeminarDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.seminarTitleLbl.textColor =[UIColor pxColorWithHexValue:@"3f51b5"];
    self.seminarTitleLbl.numberOfLines = 0;
    self.seminarTitleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    self.seminarTitleLbl.textAlignment = NSTextAlignmentCenter;
    
    [self.mapBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.mapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.mapBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    UIImage *img = [UIImage imageNamed:@"btn_map"];
    [self.mapBtn setImage:img forState:UIControlStateNormal];
    
    //self.mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -img.size.width, 0, 0);
    self.mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
    self.mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.mapBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.mapBtn.clipsToBounds = YES;
    
    [self.registerBtn setBackgroundColor:[UIColor pxColorWithHexValue:@"3f51b5"]];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.registerBtn.layer.cornerRadius = [AppDelegate sharedAppDelegate].btnRad;
    
    self.registerBtn.titleLabel.font = [AppDelegate sharedAppDelegate].btnFont;
    self.registerBtn.clipsToBounds = YES;
    
//    for(int i=1; i<=3; i++)
//    {
        UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
        leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [leftRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:leftRecognizer];
//    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.view.frame.size.height+50);

}

- (void)viewDidAppear:(BOOL)animated {
        CGFloat global_height;
//        [self.venueTextView sizeToFit];
        CGRect venueTxvFrame = self.venueTextView.frame;
        venueTxvFrame.size.height = self.venueTextView.contentSize.height;
        self.venueTextView.frame = venueTxvFrame;
        [self.venueTextView setFrame:venueTxvFrame];
        [self.venueTextView setUserInteractionEnabled:NO];
        self.venueTextView.textContainer.lineFragmentPadding = 0;
        //    self.venueTextView.textContainerInset = UIEdgeInsetsZero;
        global_height = self.venueTextView.frame.origin.y+self.venueTextView.frame.size.height;
    
        global_height += 20;
        CGRect mapBtnFrame = self.mapBtn.frame;
        mapBtnFrame.origin.y = global_height;
        [self.mapBtn setFrame:mapBtnFrame];
        global_height += mapBtnFrame.size.height;
    
        global_height += 20;
        CGRect detailLblFrame = self.detailLbl.frame;
        detailLblFrame.origin.y = global_height;
        self.detailLbl.frame = detailLblFrame;
        global_height += detailLblFrame.size.height;
    
        global_height += 20;
        CGRect detailTxvFrame = self.detailTextView.frame;
        detailTxvFrame.origin.y = global_height;
        self.detailTextView.frame = detailTxvFrame;
        global_height += detailTxvFrame.size.height;
    [super viewDidAppear:animated];
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
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    self.seminarTitleLbl.text = AMLocalizedString([self.seminar getTitle], nil);
    self.dateLbl.text = AMLocalizedString(@"Date:", nil);
    NSLog(@"seminar Date=%@", [DateUtil dateFromString:[self.seminar getLdate]]);
    NSString *seminarDate = [self.seminar getLdate];
    self.dateTextView.text = [DateUtil formattedDate:seminarDate language:LocalizationGetLanguage isLongDate:YES];
    self.dateTextView.scrollEnabled = NO;
    self.timeLbl.text = AMLocalizedString(@"Time:", nil);
    self.timeTextView.text = AMLocalizedString([self.seminar getTime], nil);
    self.timeTextView.scrollEnabled = NO;
    self.venueLbl.text = AMLocalizedString(@"Venue:", nil);
    self.venueTextView.text = AMLocalizedString([self.seminar getVenue], nil);
    self.venueTextView.scrollEnabled = NO;
    self.detailLbl.text = AMLocalizedString(@"Details:", nil);
    self.detailTextView.text = AMLocalizedString([self.seminar getDetail], nil);
    self.detailTextView.scrollEnabled = NO;
    
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
    [self.registerBtn setTitle:AMLocalizedString(@"RegisterSeminarBtnText", nil) forState:UIControlStateNormal];
    [self.mapBtn setTitle:AMLocalizedString(@"MapBtnText", nil) forState:UIControlStateNormal];
    [self.mapBtn setTintColor:[UIColor whiteColor]];
    
    self.dateLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.timeLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.venueLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.detailLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.seminarTitleLbl.font = [AppDelegate sharedAppDelegate].boldTextFont;
    self.dateTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.timeTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.venueTextView.font = [AppDelegate sharedAppDelegate].textFont;
    self.detailTextView.font = [AppDelegate sharedAppDelegate].textFont;

}

- (IBAction)btnMenuPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
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

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    ivc.seminar = self.seminar;
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction) btnRegisterPressed:(id)sendet
{
    NSString *vcName = @"RegisterSeminarViewController";

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterSeminarViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    ivc.seminar = self.seminar;
    [self.navigationController pushViewController:ivc animated:YES];
}

@end
