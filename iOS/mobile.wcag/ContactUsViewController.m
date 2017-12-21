//
//  ContactUsViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "ContactUsViewController.h"
#import "UIColor+PXExtensions.h"

@interface  ContactUsViewController() {
    CusTabBarController *tab;
}

@end


@implementation ContactUsViewController

//@synthesize title;

-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate sharedAppDelegate].viewNum = 5;
    tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
 
    [self loadHtml];
    [self.webView loadHTMLString:self.embedHTML baseURL:[NSURL URLWithString:@"about:blank"]];
    
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
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:@"Contact Us"];
}

-(void)loadHtml
{
    NSString *style;
    
    NSString *lang = @"";
    
    lang = LocalizationGetLanguage;
    
    style = [NSString stringWithFormat:@"<html><head><style>body{font-family: '-apple-system','HelveticaNeue';font-size: %@px;padding:60px;} span{font-weight:bold; font-size: %@px;}</style></head>",[AppDelegate sharedAppDelegate].webFont, [AppDelegate sharedAppDelegate].webFont];
    
    
    if([lang hasPrefix:@"en"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p><span>Accessibility Statement</span></p><p>We have incorporated appropriate accessibility features in this app, if you still encounter difficulties in using this app, please contact us via email, enquiry@ogcio.gov.hk.</p><p>Telephone number : <a href=\"tel://+85225824520\">(852) 2582 4520</a><br>                   E-mail address : <a href=\"mailto:enquiry@ogcio.gov.hk\">enquiry@ogcio.gov.hk</a></p></body></html>", style];
    }
    else if([lang hasPrefix:@"zh-Hant"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p><span>無障礙聲明</span></p><p>本手機應用程式中採用了無障礙設計。 如對本手機應用程式在使用上有任何查詢或意見，請發送電郵至 enquiry@ogcio.gov.hk 與我們聯絡。</p><p>電話號碼：<a href=\"tel://+85225824520\">(852)2582 4520</a><br>                   電郵地址：<a href=\"mailto:enquiry@ogcio.gov.hk\">enquiry@ogcio.gov.hk</a></p></body></html>", style];
    }
    else if([lang hasPrefix:@"zh-Hans"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p><span>无障碍声明</span></p><p>本手机应用程式中采用了无障碍设计。如对本手机应用程式在使用上有任何查询或意见，请发送电邮至 enquiry@ogcio.gov.hk 与我们联络。 </p><p>电话号码：<a href=\"tel://+85225824520\">(852)2582 4520</a><br> 电邮地址：<a href=\"mailto:enquiry@ogcio.gov.hk\">enquiry@ogcio.gov.hk</a></p></body></html>", style];
    }

}

-(void)addWKWebView
{
    self.webView.navigationDelegate = self;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.userInteractionEnabled = YES;
    self.webView.opaque = NO;
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView loadHTMLString: self.embedHTML baseURL: nil];
    [self.view addSubview:self.webView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.webView clearsContextBeforeDrawing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHtml];
    [self addWKWebView];
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

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    NSURL         *url = navigationAction.request.URL;
    
    if (!navigationAction.targetFrame) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    NSLog(@"url=%@", url);
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            //[app openURL:url];
            [UIApplication.sharedApplication openURL:navigationAction.request.URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    else if ([url.scheme isEqualToString:@"mailto"])
    {
        if ([app canOpenURL:url])
        {
            [UIApplication.sharedApplication openURL:navigationAction.request.URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
