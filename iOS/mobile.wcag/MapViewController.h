//
//  MapViewController.h
//  mobile.wcag
//
//

#ifndef MapViewController_h
#define MapViewController_h
#import <GoogleMaps/GoogleMaps.h>
#import "Seminar.h"
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface MapViewController : UIViewController

@property(nonatomic, strong) UILabel *addressLbl;
@property(nonatomic, strong) GMSMapView *mapView;
@property(nonatomic, strong) NSString *address;

-(IBAction)btnMenuPressed:(id)sender;
-(IBAction) btnBackPressed:(id)sender;

@property(nonatomic, strong) Seminar *seminar;

@end

#endif /* MapViewController_h */
