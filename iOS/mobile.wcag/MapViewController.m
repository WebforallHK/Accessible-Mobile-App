//
//  MapViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"
#import "AddressViewController.h"
#import "AppDelegate.h"

@interface MapViewController() {
    CusTabBarController *tab;
}

@end

@implementation MapViewController

// You don't need to modify the default initWithNibName:bundle: method.

-(void)loadNavigation
{
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
    
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"MapTitle"];
    [self.navigationController setNavigationBarHidden:NO];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.seminar getMapLong]
                                                            longitude:[self.seminar getMapLat]
                                                                 zoom:19];
    if (isiPad)
        self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-300) camera:camera];
    else
        self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200) camera:camera];
    [self.view addSubview:self.mapView];
    self.mapView.myLocationEnabled = YES;
    self.mapView.accessibilityElementsHidden = YES;
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.seminar getMapLong], [self.seminar getMapLat]);
    marker.title = AMLocalizedString([self.seminar getTitle], nil);
    marker.snippet = AMLocalizedString([self.seminar getVenue], nil);
    marker.map = self.mapView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.address = AMLocalizedString([self.seminar getVenue], nil);
    
    if (isiPad)
        self.addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, [[UIScreen mainScreen] bounds].size.height-300-100, [[UIScreen mainScreen] bounds].size.width-30, 300)];
    else
        self.addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, [[UIScreen mainScreen] bounds].size.height-200-49, [[UIScreen mainScreen] bounds].size.width-30, 200)];
    self.addressLbl.text = self.address;
    self.addressLbl.font = [AppDelegate sharedAppDelegate].textFont;
    self.addressLbl.numberOfLines = 0;
    self.addressLbl.backgroundColor = [UIColor yellowColor];
    self.addressLbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; 
    self.addressLbl.minimumScaleFactor = 10.0f/12.0f;
    self.addressLbl.clipsToBounds = YES;
    self.addressLbl.backgroundColor = [UIColor clearColor];
    self.addressLbl.textColor = [UIColor blackColor];
    self.addressLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.addressLbl];
}

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 2;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    [self loadNavigation];
//    self.mapView
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

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
