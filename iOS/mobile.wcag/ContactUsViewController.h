//
//  ContactUsViewController.h
//  mobile.wcag
//
//

#ifndef ContactUsViewController_h
#define ContactUsViewController_h

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface ContactUsViewController : UIViewController<WKNavigationDelegate>

@property(strong,nonatomic) WKWebView *webView;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *embedHTML;

@end
#endif /* ContactUsViewController_h */
