//
//  AboutDetailViewController.m
//  mobile.wcag
//
//

#import <Foundation/Foundation.h>
#import "AboutDetailViewController.h"
#import "UIColor+PXExtensions.h"

@interface  AboutDetailViewController() {
    CusTabBarController *tab;
}

@end


@implementation AboutDetailViewController

@synthesize title;

-(void)viewWillAppear:(BOOL)animated
{
    tab = [CusTabBarController sharedInstance];
    tab.viewNum = 1;
    [self.view addSubview:tab];
    
    [[AppDelegate sharedAppDelegate] updateEnv];
    
    [self loadHtml];
    [self.webView loadHTMLString:self.embedHTML baseURL:[NSURL URLWithString:@"about:blank"]];
    
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
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = AMLocalizedString(self.title, nil);
    
    self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getTitleLabel:AMLocalizedString(self.title,nil)];
    
}

-(void)loadHtml
{
    self.embedHTML = @"";
    NSString *style =@"";
    NSString *lang = @"";
    
    lang = LocalizationGetLanguage;
    
    style = [NSString stringWithFormat:@"<html><head><style>body{font-family: '-apple-system','HelveticaNeue';font-size: %@px;padding:60px;}</style></head>",[AppDelegate sharedAppDelegate].webFont];
    
    if([self.title isEqualToString:@"LeadershipTitle"] && [lang hasPrefix:@"en"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>The Government has developed a set of accessibility requirements and best practices for the design of government websites and e-services since 1999, and published them in the Guidelines on Dissemination of Information through Government Websites for all Bureaux and Departments. With effect from 1 January 2013, we required all government websites to meet the more stringent requirements under Level AA standard of the Web Content Accessibility Guidelines Version 2.0 promulgated by the World Wide Web Consortium. For instance, websites should be able to work with screen readers and use colours that are visible to persons with colour blindness, so that persons with visual impairment can obtain the online information; all audio contents on websites should have text transcript or subtitles to ensure that hearing-impaired persons can obtain the information transmitted through sound.</p><p>&nbsp;</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"LeadershipTitle"] && [lang hasPrefix:@"zh-Hant"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>政府自1999年以來已制訂無障礙網頁指引及良好作業模式，並向各局及部門發布「政府網頁發放資料指引（只提供英文版）」。 於2013年1月1日起，我們規定所有政府網站必須符合萬維網聯盟發布的《無障礙網頁內容指引》2.0版AA級別標準下的更嚴格標準。例如，網站應能配合使用屏幕閱讀軟件及色盲人士可看得到的顏色，方便視障人士接收網頁的資訊內容；網站所有聲音內容需附有文字稿或在視像內容配上字幕，以確保聽障人士能接收到這些通過聲音傳遞的資訊。</p><p>&nbsp;</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"LeadershipTitle"] && [lang isEqualToString:@"zh-Hans"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>政府自1999年以来已制订无障碍网页指引及良好作业模式，并向各局及部门发布「政府网页发放资料指引（只提供英文版）」。于2013年1月1日起，我们规定所有政府网站必须符合万维网联盟发布的《无障碍网页内容指引》2.0版AA级别标准下的更严格标准。例如，网站应能配合使用屏幕阅读软件及色盲人士可看得到的颜色，方便视障人士接收网页的资讯内容；网站所有声音内容需附有文字稿或在视像内容配上字幕，以确保听障人士能接收到这些通过声音传递的资讯。</p><p>&nbsp;</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"AwarenessTitle"] && [lang hasPrefix:@"en"])
    {
        
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>To enhance the public’s knowledge and awareness on web/mobile app accessibility, the OGCIO has organised the following activities:</p><p><span style='color:#00838F'>Webforall Facebook Fan Page</span> – to promulgate latest information about web/mobile app accessibility campaign.</p><p><span style='color:#00838F'>Webforall Video Channel</span> – to share a series of video introducing various web/mobile app accessibility features and criteria.</p><p><span style='color:#00838F'>Webforall e-Bulletin</span> – to share information and knowledge on web/mobile app accessibility.</p><p><span style='color:#00838F'>Quiz</span> – to test your basic knowledge on web/mobile app accessibility.</p><p><span style='color:#00838F'>Web/Mobile App Designers' Corner</span> – to facilitate sourcing of ICT professional services for the implementation of web/mobile app accessibility designs. Interested service providers can sign up by providing information on their services and a maximum of two projects involving web/mobile app service undertaken by them. The information will be posted onto the Government’s Internet and Intranet websites for reference by Government and visitors of the website.</p><p><span style='color:#00838F'>Legal Cases</span> – to share overseas lawsuit cases of web accessibility.</p></body></html>", style];
        
    }
    else if([self.title isEqualToString:@"AwarenessTitle"] && [lang hasPrefix:@"zh-Hant"])
    {
        
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>為提高公眾對無障礙網頁／流動應用程式的知識和認知，政府資訊科技總監辦公室舉辦了以下活動：</p><p><span style='color:#00838F'>Webforall Facebook 專頁</span> - 發布最新無障礙網頁／流動應用程式的消息。</p><p><span style='color:#00838F'>Webforall 短片頻道</span> – 分享一系列短片介紹無障礙網頁／流動應用程式的功能和準則。</p><p><span style='color:#00838F'>Webforall 電子報</span> – 分享無障礙網頁／流動應用程式的資訊和知識。</p><p><span style='color:#00838F'>問答遊戲</span> – 讓你測試對無障礙網頁／流動應用程式的基本認識。</p><p><span style='color:#00838F'>網頁／流動應用程式服務商專區</span> – 方便各界採購有關無障礙網頁設計的資訊及通訊科技專業服務。有意在專區內提供其資料的服務供應商可向我們登記，並列出最多兩個曾負責的網頁／流動應用程式設計項目。資料將公佈在政府的互聯網和內聯網網站上，供政府和網站訪客參考。</p><p><span style='color:#00838F'>法律案件</span> – 分享無障礙網頁設計的海外訴訟個案。</p></body></html>", style];
        
    }
    else if([self.title isEqualToString:@"AwarenessTitle"] && [lang isEqualToString:@"zh-Hans"])
    {
        
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>为提高公众对无障碍网页／流动应用程式的知识和认知，政府资讯科技总监办公室举办了以下活动：</p><p><span style='color:#00838F'>Webforall Facebook 专页</span> - 发布最新无障碍网页／流动应用程式的消息。 </p><p><span style='color:#00838F'>Webforall 短片频道</span> – 分享一系列短片介绍无障碍网页／流动应用程式的功能和准则。 </p><p><span style='color:#00838F'>Webforall 电子报</span> – 分享无障碍网页／流动应用程式的资讯和知识。 </p><p><span style='color:#00838F'>问答游戏</span> – 让你测试对无障碍网页／流动应用程式的基本认识。 </p><p><span style='color:#00838F'>网页／流动应用程式服务商专区</span> – 方便各界采购有关无障碍网页设计的资讯及通讯科技专业服务。有意在专区内提供其资料的服务供应商可向我们登记，并列出最多两个曾负责的网页／流动应用程式设计项目。资料将公布在政府的互联网和内联网网站上，供政府和网站访客参考。 </p><p><span style='color:#00838F'>法律案件</span> – 分享无障碍网页设计的海外诉讼个案。</p></body></html>", style];
        
    }
    else if([self.title isEqualToString:@"TipsTitle"] && [lang hasPrefix:@"en"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>We provide an array of practical information and resources to facilitate implement web/mobile app accessibility:</p><p><span style='color:#303F9E'>Mobile Application Accessibility Handbook</span> – to provide mobile application owners and developers a practical guide on basic concept and best practices for making mobile applications accessible.</p><p><span style='color:#303F9E'>Web Accessibility Handbook</span> – to provide a handy reference for both senior and frontline management on web accessibility as well as the latest international web content accessibility standards and guidelines.</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"TipsTitle"] && [lang hasPrefix:@"zh-Hant"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>為方便制作無障礙網頁／流動應用程式，我們提供一系列實用資料及資源：</p><p><span style='color:#303F9E'>無障礙流動應用程式手冊</span> – 為流動應用程式擁有者及開發人員提供實用指南，並介紹基本概念及良好作業模式，以協助開發無障礙流動應用程式。</p><p><span style='color:#303F9E'>無障礙網頁手冊</span> – 為高級行政人員及經理提供一個無障礙網頁的便利參考，以及國際上最新的無障礙網頁標準和指引。</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"TipsTitle"] && [lang isEqualToString:@"zh-Hans"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>为方便制作无障碍网页／流动应用程式，我们提供一系列实用资料及资源：</p><p><span style='color:#303F9E'>无障碍流动应用程式手册</span> – 为流动应用程式拥有者及开发人员提供实用指南，并介绍基本概念及良好作业模式，以协助开发无障碍流动应用程式。 </p><p><span style='color:#303F9E'>无障碍网页手册</span> – 为高级行政人员及经理提供一个无障碍网页的便利参考，以及国际上最新的无障碍网页标准和指引。</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"ExpertiseTitle"] && [lang hasPrefix:@"en"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>To inculcate web/mobile app accessibility as part of the skill set and professional ethics of ICT practitioners, the OGCIO has organised the following activities:</p><p><span style='color:#9E005D'>Web/Mobile App Accessibility Seminars and Technical Workshops</span> – to help corporations and organisations better understand the importance of web/mobile app accessibility, share best practices and related skills for making their mobile applications and websites accessible.</p><p><span style='color:#9E005D'>Incorporating Web/Mobile App Accessibility into ICT Curriculum</span> – to inculcate the future ICT workforce with professional knowledge and ethics by inviting higher education institutions to incorporate web/mobile app accessibility in their ICT curriculum.</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"ExpertiseTitle"] && [lang hasPrefix:@"zh-Hant"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>為了培育資訊及通訊科技從業員在無障礙網頁設計方面的技能和專業操守，政府資訊科技總監辦公室舉辦了以下活動：</p><p><span style='color:#9E005D'>無障礙網頁／流動應用程式研討會和技術工作坊</span> – 幫助企業和機構更好地了解無障礙網頁／流動應用程式的重要性，分享無障礙設計的良好作業模式和相關技術，以協助他們制作無障礙網站及流動應用程式。</p><p><span style='color:#9E005D'>把無障礙網頁／流動應用程式課題納入資訊及通訊科技課程內</span> – 籲請大專院校把無障礙網頁／流動應用程式課題納入其資訊及通訊科技課程內，為向未來資訊及通訊科技從業員灌輸無障礙設計的專業知識和培養他們在這方面的專業操守。詳情請參閱課程一覽表。</p></body></html>", style];
    }
    else if([self.title isEqualToString:@"ExpertiseTitle"] && [lang isEqualToString:@"zh-Hans"])
    {
        self.embedHTML = [NSString stringWithFormat:@"%@<body><p>为了培育资讯及通讯科技从业员在无障碍网页设计方面的技能和专业操守，政府资讯科技总监办公室举办了以下活动：</p><p><span style='color:#9E005D'>无障碍网页／流动应用程式研讨会和技术工作坊</span> – 帮助企业和机构更好地了解无障碍网页／流动应用程式的重要性，分享无障碍设计的良好作业模式和相关技术，以协助他们制作无障碍网站及流动应用程式。 </p><p><span style='color:#9E005D'>把无障碍网页／流动应用程式课题纳入资讯及通讯科技课程内</span> – 吁请大专院校把无障碍网页／流动应用程式课题纳入其资讯及通讯科技课程内，为向未来资讯及通讯科技从业员灌输无障碍设计的专业知识和培养他们在这方面的专业操守。详情请参阅课程一览表。</p></body></html>", style];
    }
    
    NSLog(@"title=%@", title);
    CusTabBarController * tab = [CusTabBarController sharedInstance];
    [self.view addSubview:tab];
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

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self loadHtml];
    [self addWKWebView];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    
    
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

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    CGFloat addViewHeight = 300.0;
    self.addView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, webView.frame.size.width, addViewHeight)];
    self.addView.backgroundColor = [UIColor clearColor];
    [webView.scrollView addSubview:self.addView];

    NSString *js = [NSString stringWithFormat:@"\
                    var appendDiv = document.getElementById(\"AppAppendDIV\");\
                    if (appendDiv) {\
                    appendDiv.style.height = %@+\"px\";\
                    } else {\
                    var appendDiv = document.createElement(\"div\");\
                    appendDiv.setAttribute(\"id\",\"AppAppendDIV\");\
                    appendDiv.style.width=%@+\"px\";\
                    appendDiv.style.height=%@+\"px\";\
                    document.body.appendChild(appendDiv);\
                    }\
                    ", @(addViewHeight), @(self.webView.frame.size.width), @(addViewHeight)];

    [self.webView evaluateJavaScript:js completionHandler:nil];

}

- (void)viewWillDisappear:(BOOL)animated {
    [tab removeFromSuperview];
}

@end
