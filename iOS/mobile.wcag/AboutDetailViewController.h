//
//  AboutDetailViewController.h
//  mobile.wcag
//
//

#ifndef AboutDetailViewController_h
#define AboutDetailViewController_h
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "CusTabBarController.h"

@interface AboutDetailViewController : UIViewController<WKNavigationDelegate>

//@property(nonatomic, strong) IBOutlet UIWebView *webView;
@property(strong,nonatomic) WKWebView *webView;
@property(nonatomic, weak) NSString *title;
@property(strong,nonatomic) NSString *embedHTML;
@property (strong,nonatomic) UIView *addView;
@end

#endif /* AboutDetailViewController_h */
